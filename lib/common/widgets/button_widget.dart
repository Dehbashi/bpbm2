import 'package:flutter/material.dart';

class ButtonWidget extends StatelessWidget {
  // const ButtonWidget({super.key});
  final String text;
  final Function() onPressed;
  final double buttonWidth;
  final Color? color;
  final bool isDisabled;
  final bool isLoading;
  final Icon? icon;

  const ButtonWidget({
    super.key,
    required this.onPressed,
    required this.text,
    this.buttonWidth = 150,
    this.color,
    this.isDisabled = false,
    this.isLoading = false,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: buttonWidth,
      height: 45,
      child: ElevatedButton(
        onPressed: isDisabled ? null : onPressed,
        style: ButtonStyle(
          backgroundColor: isDisabled
              ? MaterialStateProperty.all(Colors.grey)
              : MaterialStateProperty.all(
                  color ?? Theme.of(context).colorScheme.onPrimary,
                ),
          textStyle: MaterialStateProperty.all(
            const TextStyle(
              fontFamily: 'iranSans',
              fontSize: 16,
              inherit: true,
            ),
          ),
        ),
        child: isLoading
            ? Transform.scale(
                scale: 0.75,
                child: const CircularProgressIndicator(
                  color: Colors.white,
                  strokeCap: StrokeCap.square,
                ),
              )
            : Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if (icon != null)
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        icon!,
                        const SizedBox(
                          width: 4,
                        ),
                      ],
                    ),
                  Expanded(
                    child: Text(
                      text,
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}
