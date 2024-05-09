import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:bpbm2/common/custom_error_messenger.dart';
import 'package:bpbm2/common/dialogs/loading_screen.dart';
import 'package:bpbm2/common/methods/device_info.dart';
import 'package:bpbm2/common/methods/load_token.dart';
import 'package:bpbm2/data/models/address_model/address_model.dart';
import 'package:bpbm2/data/models/address_model/map_model.dart';
import 'package:bpbm2/data/repo/address_repository.dart';
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
        String token = await loadToken();
        LoadingScreen.instance().show(
          context: context,
          text: 'در حال بارگذاری',
        );
        if (token.isNotEmpty) {
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
        });
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
