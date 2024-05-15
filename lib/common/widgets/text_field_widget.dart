import 'package:flutter/material.dart';

class TextFieldWidget extends StatelessWidget {
  final void Function(String?)? onSaved;
  final String? Function(String?)? validator;
  final String? hintText;
  final String? labelText;
  final double? height;
  final double? width;
  final TextInputType? textInputType;
  final TextEditingController? controller;

  const TextFieldWidget({
    super.key,
    required this.onSaved,
    required this.validator,
    this.hintText,
    this.height = 35,
    this.labelText,
    this.width = double.infinity,
    this.textInputType,
    this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(0, 5, 0, 5),
      width: width,
      // height: height,
      // width: double.infinity,
      child: TextFormField(
        onSaved: onSaved,
        validator: validator,
        controller: controller,
        style: Theme.of(context).textTheme.bodyMedium,
        textAlignVertical: TextAlignVertical.top,
        maxLines: null,
        // expands: true,
        keyboardType: textInputType,
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
          hintText: hintText ?? '',
          hintStyle: Theme.of(context).textTheme.bodyMedium!.copyWith(
                color: Theme.of(context).colorScheme.onPrimaryContainer,
              ),
          label: labelText != null ? Text(labelText!) : null,
          labelStyle: Theme.of(context).textTheme.bodyMedium!.copyWith(
                color: Theme.of(context).colorScheme.onPrimaryContainer,
              ),
          filled: true,
          fillColor: Colors.white,
          border: const OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.all(
              Radius.circular(5),
            ),
          ),
        ),
      ),
    );
  }
}
