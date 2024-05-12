import 'package:flutter/material.dart';

class DiscriptionBox extends StatelessWidget {
  final TextEditingController controller;
  const DiscriptionBox({
    super.key,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('توضیحات'),
        const SizedBox(
          height: 10,
        ),
        SizedBox(
          height: 200,
          child: TextFormField(
            controller: controller,
            expands: true,
            maxLines: null,
            cursorColor: Theme.of(context).colorScheme.onPrimary,
            textAlign: TextAlign.start,
            textAlignVertical: TextAlignVertical.top,
            decoration: InputDecoration(
              contentPadding: const EdgeInsets.all(10),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(
                  color: Theme.of(context).colorScheme.primary,
                  width: 2,
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(
                  color: Theme.of(context).colorScheme.primary,
                  width: 2,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
