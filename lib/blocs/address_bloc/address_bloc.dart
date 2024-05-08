import 'package:bloc/bloc.dart';
import 'package:bpbm2/common/custom_error_messenger.dart';
import 'package:bpbm2/common/dialogs/loading_screen.dart';
import 'package:bpbm2/common/methods/device_info.dart';
import 'package:bpbm2/common/methods/load_token.dart';
import 'package:bpbm2/data/models/address_model/address_model.dart';
import 'package:bpbm2/data/models/address_model/map_model.dart';
import 'package:bpbm2/data/repo/address_repository.dart';
import 'package:bpbm2/data/repo/auth_repository.dart';
import 'package:bpbm2/providers/price_provider.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

part 'address_event.dart';
part 'address_state.dart';

class AddressBloc extends Bloc<AddressEvent, AddressState> {
  AddressBloc() : super(AddressInitial()) {
    int transportationCost = 0;
    List<int> transportationCosts = [];
    on<AddressEvent>((event, emit) async {
      if (event is AddressStarted) {
        String token = await loadToken();
        LoadingScreen.instance().show(
          context: event.context,
          text: 'در حال بارگذاری',
        );
        if (token.isNotEmpty) {
          await addressRepository.fetchAddress().then((addresses) async {
            if (addresses.isNotEmpty) {
              // transportationCost =
              //     await addressRepository.fetchTransportationPrice(
              //   municipalityZone: event.address.municipalityZone,
              // );
              emit(
                CurrentAddressSuccess(
                  addresses: addresses,
                  transportationCost: transportationCost,
                  currentAddressScreen: true,
                ),
              );
              LoadingScreen.instance().hide();
            } else {
              emit(
                CurrentAddressSuccess(
                    addresses: addresses,
                    transportationCost: transportationCost,
                    emptyMessage: 'آدرسی وجودد ندارد',
                    currentAddressScreen: true),
              );
              LoadingScreen.instance().hide();
            }
          }).catchError((e) {
            LoadingScreen.instance().hide();
            customErrorMessenger(
              context: event.context,
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
            ),
          );
          LoadingScreen.instance().hide();
        }
      }

      if (event is CurrentAddressSelected) {
        final provider =
            Provider.of<PriceProvider>(event.context, listen: false);
        if (transportationCosts.isNotEmpty) {
          provider.removeItem(price: transportationCosts.last);
          transportationCosts.removeLast();
        }
        transportationCost = await addressRepository.fetchTransportationPrice(
          municipalityZone: event.address.municipalityZone,
        );
        transportationCosts.add(transportationCost);
        provider.addItem(price: transportationCost);
        emit(
          CurrentAddressSuccess(
            addresses: event.addresses,
            transportationCost: transportationCost,
            currentAddressScreen: true,
          ),
        );
      }

      if (event is NewAddressStarted) {
        final deviceInfo = DeviceInfo();
        LoadingScreen.instance().show(
          context: event.context,
          text: 'در حال بارگذاری',
        );
        await deviceInfo.determinePosition().then((position) async {
          await addressRepository
              .fetchLocationFromMap(
                  lat: position.latitude, lng: position.longitude)
              .then((location) {
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
        final provider =
            Provider.of<PriceProvider>(event.context, listen: false);
        if (transportationCosts.isNotEmpty) {
          provider.removeItem(price: transportationCosts.last);
          transportationCosts.removeLast();
        }
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
          transportationCosts.add(transportationCost);
          provider.addItem(price: transportationCost);
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
}
