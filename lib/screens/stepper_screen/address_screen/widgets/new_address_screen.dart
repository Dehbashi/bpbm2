import 'dart:convert';

import 'package:bpbm2/blocs/address_bloc/address_bloc.dart';
import 'package:bpbm2/blocs/stepper_bloc/stepper_bloc.dart';
import 'package:bpbm2/common/widgets/button_widget.dart';
import 'package:bpbm2/common/widgets/text_field_widget.dart';
import 'package:bpbm2/screens/stepper_screen/address_screen/widgets/address_screen_map_widget.dart';
import 'package:bpbm2/screens/stepper_screen/address_screen/widgets/address_status.dart';
import 'package:bpbm2/screens/stepper_screen/widgets/price_container.dart';
import 'package:bpbm2/screens/stepper_screen/widgets/stepper_buttons.dart';
import 'package:bpbm2/screens/stepper_screen/widgets/transportation_price_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_map/flutter_map.dart';

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
                  houseNumber: '0',
                  unit: '0',
                ),
              );
              setState(() {
                fullAddressController.text = utf8
                    .decode(widget.state.location.formattedAddress.codeUnits);
              });
            },
          ),
          const SizedBox(
            height: 10,
          ),
          Text(
            'نشانی',
            style: Theme.of(context).textTheme.titleSmall,
          ),
          Form(
            key: _formKey,
            child: Column(
              children: [
                TextFieldWidget(
                  controller: fullAddressController,
                  onSaved: (value) {},
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'لطفاً آدرس کامل خود را با انتخاب آن بر روی نقشه وارد نمایید.';
                    }
                    return null;
                  },
                  hintText: 'تهران: کارگر شمالی - انتهای کوچه فراز - کوچه یاس*',
                ),
                Row(
                  children: [
                    TextFieldWidget(
                      controller: houseNumberController,
                      width: MediaQuery.of(context).size.width * 0.4,
                      onSaved: (value) {},
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'ضروری';
                        }
                        return null;
                      },
                      hintText: 'پلاک*',
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    TextFieldWidget(
                      controller: unitNumberController,
                      width: MediaQuery.of(context).size.width * 0.3,
                      onSaved: (value) {},
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'ضروری';
                        }
                        return null;
                      },
                      hintText: 'واحد*',
                    ),
                  ],
                ),
              ],
            ),
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
            onNextPressed: () {
              if (_formKey.currentState!.validate()) {
                BlocProvider.of<StepperBloc>(context).add(NextStep());
              }
            },
          ),
        ],
      ),
    );
  }
}
