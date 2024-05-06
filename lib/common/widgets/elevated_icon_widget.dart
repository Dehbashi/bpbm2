import 'package:flutter/material.dart';

class ElevatedIconWidget extends StatelessWidget {
  final Function() onPressed;
  final IconData icon;
  final String tooltip;
  final bool isActive;
  final Color? color;
  const ElevatedIconWidget({
    super.key,
    required this.onPressed,
    required this.icon,
    required this.tooltip,
    required this.isActive,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      message: tooltip,
      child: ElevatedButton(
        onPressed: isActive ? onPressed : null,
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(
            color != null
                ? color
                : isActive
                    ? Theme.of(context).colorScheme.onBackground
                    : Theme.of(context).colorScheme.onPrimaryContainer,
          ),
        ),
        child: Icon(icon),
      ),
    );
  }
}
