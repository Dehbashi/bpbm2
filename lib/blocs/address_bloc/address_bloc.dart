import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:bpbm2/common/custom_error_messenger.dart';
import 'package:bpbm2/common/dialogs/loading_screen.dart';
import 'package:bpbm2/common/methods/device_info.dart';
import 'package:bpbm2/common/methods/load_token.dart';
import 'package:bpbm2/data/models/address_model/address_model.dart';
import 'package:bpbm2/data/models/address_model/map_model.dart';
import 'package:bpbm2/data/repo/address_repository.dart';
import 'package:bpbm2/data/repo/auth_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'address_event.dart';
part 'address_state.dart';

class AddressBloc extends Bloc<AddressEvent, AddressState> {
  final BuildContext context;
  AddressBloc(this.context) : super(AddressInitial()) {
    int transportationCost = 0;
    on<AddressEvent>((event, emit) async {
      if (event is AddressStarted) {
        transportationCost = 0;
        final token = AuthRepository.authChangeNotifier.value;
        LoadingScreen.instance().show(
          context: context,
          text: 'در حال بارگذاری',
        );
        if (token != null) {
          await addressRepository.fetchAddress().then((addresses) async {
            if (addresses.isNotEmpty) {
              emit(
                CurrentAddressSuccess(
                  addresses: addresses,
                  transportationCost: transportationCost,
                  currentAddressScreen: true,
                  isFirstTime: true,
                ),
              );
              LoadingScreen.instance().hide();
            } else {
              emit(
                CurrentAddressSuccess(
                  addresses: addresses,
                  transportationCost: transportationCost,
                  emptyMessage: 'آدرسی وجودد ندارد',
                  currentAddressScreen: true,
                  isFirstTime: true,
                ),
              );
              LoadingScreen.instance().hide();
            }
          }).catchError((e) {
            LoadingScreen.instance().hide();
            customErrorMessenger(
              context: context,
              message: 'خطای نامشخص',
            );
          });
        } else {
          emit(
            const CurrentAddressSuccess(
              addresses: [],
              transportationCost: 0,
              emptyMessage: 'شما وارد سامانه نشده اید',
              currentAddressScreen: true,
              isFirstTime: true,
            ),
          );
          LoadingScreen.instance().hide();
        }
      }

      if (event is CurrentAddressSelected) {
        transportationCost = await addressRepository.fetchTransportationPrice(
          municipalityZone: event.address.municipalityZone,
        );
        emit(
          CurrentAddressSuccess(
            addresses: event.addresses,
            transportationCost: transportationCost,
            currentAddressScreen: true,
            isFirstTime: false,
          ),
        );
        await saveCurrentAddress(
          transportationCost: transportationCost,
          address: event.address,
        );
      }

      if (event is NewAddressStarted) {
        transportationCost = 0;
        final deviceInfo = DeviceInfo();
        LoadingScreen.instance().show(
          context: context,
          text: 'در حال بارگذاری',
        );
        await deviceInfo.determinePosition().then((position) async {
          await addressRepository
              .fetchLocationFromMap(
                  lat: position.latitude, lng: position.longitude)
              .then((location) async {
            await addressRepository
                .fetchTransportationPrice(
              municipalityZone: int.parse(location.municipalityZone),
            )
                .then((transportationCost) {
              emit(
                NewAddressSuccess(
                  transportationCost: transportationCost,
                  currentAddressScreen: false,
                  location: location,
                  lat: position.latitude,
                  lng: position.longitude,
                ),
              );
            });
          });
          LoadingScreen.instance().hide();
        }).catchError((e) {
          LoadingScreen.instance().hide();
          customErrorMessenger(
            context: event.context,
            message: 'خطای نامشخص',
          );
        });
      }

      if (event is RegisterNewAddress) {
        await addressRepository
            .fetchLocationFromMap(
          lat: event.lat,
          lng: event.lng,
        )
            .then((location) async {
          final transportationCost =
              await addressRepository.fetchTransportationPrice(
            municipalityZone: int.parse(location.municipalityZone),
          );
          emit(
            NewAddressSuccess(
              transportationCost: transportationCost,
              currentAddressScreen: false,
              location: location,
              lat: event.lat,
              lng: event.lng,
            ),
          );
          // AddressModel address = AddressModel(
          //   id: 0,
          //   title: '-',
          //   text: utf8.decode(location.formattedAddress.codeUnits),
          //   lat: event.lat.toString(),
          //   lng: event.lng.toString(),
          //   city: location.city ?? '',
          //   district: location.district ?? '',
          //   municipalityZone: int.parse(location.municipalityZone),
          //   houseNumber: event.houseNumber,
          //   unit: event.unit,
          //   status: int.parse(location.state ?? '0'),
          // );
          // saveCurrentAddress(
          //   transportationCost: transportationCost,
          //   address: address,
          // );
        });
      }

      if (event is EditAddressStarted) {
        emit(
          EditAddressSuccess(address: event.address),
        );
      }

      if (event is EditCurrentAddress) {
        await addressRepository
            .fetchLocationFromMap(lat: event.lat, lng: event.lng)
            .then((location) async {
          final transportationCost =
              await addressRepository.fetchTransportationPrice(
            municipalityZone: int.parse(location.municipalityZone),
          );
          emit(
            NewAddressSuccess(
                transportationCost: transportationCost,
                currentAddressScreen: false,
                location: location,
                lat: event.lat,
                lng: event.lng),
          );
        });
      }

      if (event is SaveNewAddress) {
        // AddressModel address = AddressModel(
        //   id: 0,
        //   title: '-',
        //   text: utf8.decode(event.address.formattedAddress.codeUnits),
        //   lat: 'event.lat.toString()',
        //   lng: 'event.lng.toString()',
        //   city: utf8.decode((event.address.city ?? '').codeUnits),
        //   district: utf8.decode((event.address.district ?? '').codeUnits),
        //   municipalityZone: int.parse(event.address.municipalityZone),
        //   houseNumber: event.houseNumber,
        //   unit: event.unitNumber,
        //   status: int.parse(event.address.state ?? '0'),
        // );
        AddressModel address = AddressModel(
          id: 0,
          title: '-',
          text: event.fullAddress,
          lat: 'event.lat.toString()',
          lng: 'event.lng.toString()',
          city: utf8.decode((event.address.city ?? '').codeUnits),
          district: utf8.decode((event.address.district ?? '').codeUnits),
          municipalityZone: int.parse(event.address.municipalityZone),
          houseNumber: event.houseNumber,
          unit: event.unitNumber,
          status: 0,
        );
        saveCurrentAddress(
          transportationCost: transportationCost,
          address: address,
        );
      }
    });
  }

  Future<void> saveCurrentAddress({
    required int transportationCost,
    required AddressModel address,
  }) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('selectedAddress', jsonEncode(address.toJson()));
    prefs.setInt('transportationCost', transportationCost);

    // final selectedAddressJson = prefs.getString('selectedAddress');
    // if (selectedAddressJson != null) {
    //   final Map<String, dynamic> jsonData = jsonDecode(selectedAddressJson);
    //   final address = AddressModel.fromJson(jsonData);
    // }
  }
}
