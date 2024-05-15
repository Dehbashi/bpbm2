import 'dart:convert';

import 'package:bpbm2/blocs/address_bloc/address_bloc.dart';
import 'package:bpbm2/data/models/address_model/address_model.dart';
import 'package:bpbm2/screens/user_address_screen/widgets/address_create_update_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UserAddressEditScreen extends StatefulWidget {
  final AddressModel address;
  const UserAddressEditScreen({
    super.key,
    required this.address,
  });

  @override
  State<UserAddressEditScreen> createState() => _UserAddressEditScreenState();
}

class _UserAddressEditScreenState extends State<UserAddressEditScreen> {
  late AddressBloc bloc;
  TextEditingController addressController = TextEditingController();
  TextEditingController houseNumberController = TextEditingController();
  TextEditingController unitNumberController = TextEditingController();

  @override
  void initState() {
    super.initState();
    bloc = BlocProvider.of<AddressBloc>(context);
    bloc.add(EditAddressStarted(address: widget.address));
    addressController.text = widget.address.text;
    houseNumberController.text = widget.address.houseNumber ?? '';
    unitNumberController.text = widget.address.unit ?? '';
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
        if (state is EditAddressSuccess) {
          addressController.text = state.address.text;
          return AddressCreateUpdateWidget(
            addressController: addressController,
            houseNumberController: houseNumberController,
            unitNumberController: unitNumberController,
            address: widget.address,
            headerText: 'بروزرسانی آدرس',
            buttonText: 'بروزرسانی آدرس',
            lat: double.parse(widget.address.lat),
            lng: double.parse(widget.address.lng),
            onPicked: (pickedValue) {
              BlocProvider.of<AddressBloc>(context).add(
                RegisterNewAddress(
                  context: context,
                  lat: pickedValue.latLong.latitude,
                  lng: pickedValue.latLong.longitude,
                ),
              );
            },
            onVerifyPressed: () {},
          );
        } else if (state is NewAddressSuccess) {
          addressController.text =
              utf8.decode(state.location.formattedAddress.codeUnits);
          return AddressCreateUpdateWidget(
            addressController: addressController,
            houseNumberController: houseNumberController,
            unitNumberController: unitNumberController,
            address: widget.address,
            headerText: 'بروزرسانی آدرس',
            buttonText: 'بروزرسانی آدرس',
            lat: state.lat,
            lng: state.lat,
            onPicked: (pickedValue) {
              BlocProvider.of<AddressBloc>(context).add(
                RegisterNewAddress(
                  context: context,
                  lat: pickedValue.latLong.latitude,
                  lng: pickedValue.latLong.longitude,
                ),
              );
            },
            onVerifyPressed: () {},
          );
        } else {
          return Container();
        }
      },
    );
  }
}
