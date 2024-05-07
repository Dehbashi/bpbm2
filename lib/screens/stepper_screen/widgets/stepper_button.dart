import 'package:flutter/material.dart';

class StepperButton extends StatelessWidget {
  final Function() onPressed;
  final String text;
  final bool isNextStep;
  const StepperButton({
    super.key,
    required this.onPressed,
    required this.text,
    required this.isNextStep,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all(
          isNextStep
              ? Theme.of(context).colorScheme.onBackground
              : Theme.of(context).colorScheme.inversePrimary,
        ),
        foregroundColor: MaterialStateProperty.all(Colors.white),
        shape: MaterialStateProperty.all(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        fixedSize: MaterialStateProperty.all(Size(MediaQuery.of(context).size.width * 0.45, 40),),
      ),
      child: Text(text),
    );
  }
}
