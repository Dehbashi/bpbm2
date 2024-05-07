import 'package:bloc/bloc.dart';
import 'package:bpbm2/common/custom_error_messenger.dart';
import 'package:bpbm2/common/dialogs/loading_screen.dart';
import 'package:bpbm2/common/methods/load_token.dart';
import 'package:bpbm2/data/models/address_model/address_model.dart';
import 'package:bpbm2/data/models/address_model/map_model.dart';
import 'package:bpbm2/data/repo/address_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

part 'address_event.dart';
part 'address_state.dart';

class AddressBloc extends Bloc<AddressEvent, AddressState> {
  AddressBloc() : super(AddressInitial()) {
    int transportationCost = 0;
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
                    currentAddressScreen: true),
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
                currentAddressScreen: true),
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
          ),
        );
      }

      if (event is NewAddress) {
        LoadingScreen.instance().show(
          context: event.context,
          text: 'در حال بارگذاری',
        );
        await addressRepository
            .fetchLocationFromMap(lat: event.lat, lng: event.lng)
            .then((location) {
          emit(
            NewAddressSuccess(
              transportationCost: transportationCost,
              currentAddressScreen: false,
              location: location,
            ),
          );
          LoadingScreen.instance().hide();
        }).catchError((e) {
          LoadingScreen.instance().hide();
          customErrorMessenger(
            context: event.context,
            message: 'خطای نامشخص',
          );
        });
      }
    });
  }
}
