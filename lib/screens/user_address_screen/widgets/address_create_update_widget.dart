import 'package:bpbm2/common/widgets/button_widget.dart';
import 'package:bpbm2/common/widgets/flutter_map_widget.dart';
import 'package:bpbm2/common/widgets/text_field_widget.dart';
import 'package:bpbm2/data/models/address_model/address_model.dart';
import 'package:flutter/material.dart';
import 'package:location_picker_flutter_map/location_picker_flutter_map.dart';

class AddressCreateUpdateWidget extends StatelessWidget {
  final AddressModel? address;
  final String headerText;
  final double lat;
  final double lng;
  final void Function(PickedData) onPicked;
  final Function() onVerifyPressed;
  final String buttonText;
  final TextEditingController addressController;
  final TextEditingController houseNumberController;
  final TextEditingController unitNumberController;
  const AddressCreateUpdateWidget({
    super.key,
    this.address,
    required this.headerText,
    required this.lat,
    required this.lng,
    required this.onPicked,
    required this.onVerifyPressed,
    required this.buttonText,
    required this.addressController,
    required this.houseNumberController,
    required this.unitNumberController,
  });

  @override
  Widget build(BuildContext context) {
    GlobalKey<FormState> formKey = GlobalKey<FormState>();

    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Text(
                headerText,
                style: Theme.of(context).textTheme.titleSmall,
              ),
            ),
            FlutterMapWidget(
              lat: lat,
              lng: lng,
              onPicked: onPicked,
            ),
            const SizedBox(
              height: 10,
            ),
            Form(
              key: formKey,
              child: Column(
                children: [
                  TextFieldWidget(
                    controller: addressController,
                    onSaved: (value) {},
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'لطفا آدرس کامل خود را وارد نمایید';
                      }
                      return null;
                    },
                    labelText: 'آدرس جدید',
                  ),
                  const SizedBox(
                    height: 10,
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
                        labelText: 'شماره پلاک',
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
                        labelText: 'واحد',
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  ButtonWidget(
                    onPressed: () {
                      if (formKey.currentState!.validate()) {
                        onVerifyPressed();
                      }
                    },
                    text: buttonText,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
