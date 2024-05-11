import 'dart:convert';

import 'package:bpbm2/blocs/address_bloc/address_bloc.dart';
import 'package:bpbm2/blocs/stepper_bloc/stepper_bloc.dart';
import 'package:bpbm2/common/widgets/button_widget.dart';
import 'package:bpbm2/providers/price_provider.dart';
import 'package:bpbm2/screens/stepper_screen/address_screen/widgets/address_screen_map_widget.dart';
import 'package:bpbm2/screens/stepper_screen/address_screen/widgets/address_status.dart';
import 'package:bpbm2/screens/stepper_screen/address_screen/widgets/new_address_screen_form.dart';
import 'package:bpbm2/screens/stepper_screen/widgets/price_container.dart';
import 'package:bpbm2/screens/stepper_screen/widgets/stepper_buttons.dart';
import 'package:bpbm2/screens/stepper_screen/widgets/transportation_price_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

class NewAddressScreen extends StatefulWidget {
  final AddressBloc bloc;
  final NewAddressSuccess state;
  const NewAddressScreen({
    super.key,
    required this.state,
    required this.bloc,
  });

  @override
  State<NewAddressScreen> createState() => _NewAddressScreenState();
}

class _NewAddressScreenState extends State<NewAddressScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController fullAddressController = TextEditingController();
  TextEditingController houseNumberController = TextEditingController();
  TextEditingController unitNumberController = TextEditingController();

  @override
  void dispose() {
    fullAddressController.dispose();
    houseNumberController.dispose();
    unitNumberController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<PriceProvider>(context, listen: false);
    fullAddressController.text =
        utf8.decode(widget.state.location.formattedAddress.codeUnits);
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const PriceContainer(),
          ButtonWidget(
            buttonWidth: double.infinity,
            onPressed: () {
              widget.bloc.add(AddressStarted(context: context));
            },
            text: 'انتخاب نشانی های قبلی',
            icon: const Icon(
              Icons.add_location,
              size: 20,
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          TransportationPriceContainer(
            transportationPrice: widget.state.transportationCost,
          ),
          Text(
            'موقعیت مکانی نشانی را مشخص کنید',
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          const SizedBox(
            height: 10,
          ),
          AddressScreenMapWidget(
            state: widget.state,
            onPicked: (value) {
              widget.bloc.add(
                RegisterNewAddress(
                  context: context,
                  lat: value.latLong.latitude,
                  lng: value.latLong.longitude,
                ),
              );
            },
          ),
          const SizedBox(
            height: 10,
          ),
          Text(
            'نشانی',
            style: Theme.of(context).textTheme.titleSmall,
          ),
          NewAddressScreenForm(
            formKey: _formKey,
            fullAddressController: fullAddressController,
            houseNumberController: houseNumberController,
            unitNumberController: unitNumberController,
          ),
          const SizedBox(
            height: 10,
          ),
          AddressStatus(
            isCurrentAddressScreen: widget.state.currentAddressScreen,
          ),
          const SizedBox(
            height: 10,
          ),
          StepperButtons(
            onBackPressed: () {
              provider.backButtonClicked();
              BlocProvider.of<StepperBloc>(context).add(PreviousStep());
            },
            onNextPressed: () {
              if (_formKey.currentState!.validate()) {
                provider.addItem(price: widget.state.transportationCost.toDouble());
                widget.bloc.add(
                  SaveNewAddress(
                    address: widget.state.location,
                    fullAddress: fullAddressController.text,
                    houseNumber: houseNumberController.text,
                    unitNumber: unitNumberController.text,
                  ),
                );
                BlocProvider.of<StepperBloc>(context).add(NextStep());
              }
            },
          ),
        ],
      ),
    );
  }
}
