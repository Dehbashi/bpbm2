import 'package:flutter/material.dart';

class FormContainerWidget extends StatelessWidget {
  final Widget formWidget;

  const FormContainerWidget({super.key, required this.formWidget});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(10, 5, 10, 25),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.primary,
        borderRadius: BorderRadius.circular(5),
      ),
      child: formWidget,
    );
  }
}
