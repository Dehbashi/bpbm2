import 'package:flutter/material.dart';

class ScreenContainerWidget extends StatelessWidget {
  final Widget? image;
  final Widget textWidget;
  final Widget button;
  const ScreenContainerWidget({
    super.key,
    this.image,
    required this.textWidget,
    required this.button,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(10, 15, 10, 50),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Theme.of(context).colorScheme.primary,
      ),
      child: Column(
        children: [
          if (image != null) image!,
          if (image != null)
            const SizedBox(
              height: 20,
            ),
          Padding(
            padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                textWidget,
                const SizedBox(
                  height: 10,
                ),
                button
              ],
            ),
          ),
        ],
      ),
    );
  }
}
