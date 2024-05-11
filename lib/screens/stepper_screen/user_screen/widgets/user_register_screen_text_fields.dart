import 'package:bpbm2/common/widgets/text_field_widget.dart';
import 'package:flutter/material.dart';

class UserRegisterScreenTextFields extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  const UserRegisterScreenTextFields({
    super.key,
    required this.controller,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: Theme.of(context).textTheme.bodyMedium,
        ),
        const SizedBox(
          height: 5,
        ),
        TextFieldWidget(
          controller: controller,
          onSaved: (valule) {},
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'لطفاً نام یا نام خانوادگی خود را وارد نمایید';
            }
            return null;
          },
          hintText: '',
        ),
      ],
    );
  }
}
