import 'dart:convert';

import 'package:bpbm2/blocs/address_bloc/address_bloc.dart';
import 'package:bpbm2/screens/user_address_screen/widgets/address_create_update_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UserNewAddressScreen extends StatefulWidget {
  const UserNewAddressScreen({
    super.key,
  });

  @override
  State<UserNewAddressScreen> createState() => _UserNewAddressScreenState();
}

class _UserNewAddressScreenState extends State<UserNewAddressScreen> {
  late AddressBloc bloc;
  late TextEditingController addressController;
  late TextEditingController houseNumberController;
  late TextEditingController unitNumberController;

  @override
  void initState() {
    super.initState();
    bloc = BlocProvider.of<AddressBloc>(context);
    bloc.add(NewAddressStarted(context: context));
    addressController = TextEditingController();
    houseNumberController = TextEditingController();
    unitNumberController = TextEditingController();
  }

  @override
  void dispose() {
    addressController.dispose();
    houseNumberController.dispose();
    unitNumberController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AddressBloc, AddressState>(
      builder: (context, state) {
        if (state is NewAddressSuccess) {
          addressController.text = utf8.decode(
            state.location.formattedAddress.codeUnits,
          );
          return AddressCreateUpdateWidget(
            headerText: 'ایجاد آدرس جدید',
            lat: state.lat,
            lng: state.lng,
            onPicked: (pickedValue) {
              bloc.add(
                RegisterNewAddress(
                    context: context,
                    lat: pickedValue.latLong.latitude,
                    lng: pickedValue.latLong.longitude),
              );
            },
            onVerifyPressed: () {},
            buttonText: 'ایجاد آدرس',
            addressController: addressController,
            houseNumberController: houseNumberController,
            unitNumberController: unitNumberController,
          );
        } else {
          return Container();
        }
      },
    );
  }
}
