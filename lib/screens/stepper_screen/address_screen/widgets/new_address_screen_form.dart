import 'package:bpbm2/common/widgets/text_field_widget.dart';
import 'package:flutter/material.dart';

class NewAddressScreenForm extends StatelessWidget {
  final GlobalKey<FormState> formKey;
  final TextEditingController fullAddressController;
  final TextEditingController houseNumberController;
  final TextEditingController unitNumberController;
  const NewAddressScreenForm({
    super.key,
    required this.formKey,
    required this.fullAddressController,
    required this.houseNumberController,
    required this.unitNumberController,
  });

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
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
    );
  }
}
