import 'package:bloc/bloc.dart';
import 'package:bpbm2/common/custom_error_messenger.dart';
import 'package:bpbm2/common/dialogs/loading_screen.dart';
import 'package:bpbm2/data/models/address_model/address_model.dart';
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
        LoadingScreen.instance().show(
          context: event.context,
          text: 'در حال بارگذاری',
        );
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
              const CurrentAddressEmpty(message: 'آدرسی وجود ندارد'),
            );
          }
        }).catchError((e) {
          LoadingScreen.instance().hide();
          customErrorMessenger(
            context: event.context,
            message: 'خطای نامشخص',
          );
        });
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
    });
  }
}
