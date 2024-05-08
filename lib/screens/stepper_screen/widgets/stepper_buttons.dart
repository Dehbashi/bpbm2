import 'package:bpbm2/blocs/stepper_bloc/stepper_bloc.dart';
import 'package:bpbm2/screens/stepper_screen/widgets/stepper_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class StepperButtons extends StatelessWidget {
  final Function() onNextPressed;
  const StepperButtons({super.key, required this.onNextPressed});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        StepperButton(
          onPressed: () {
            BlocProvider.of<StepperBloc>(context).add(PreviousStep());
          },
          text: 'بازگشت به مرحله قبل',
          isNextStep: false,
        ),
        StepperButton(
          onPressed: onNextPressed,
          text: 'رفتن به مرحله بعد',
          isNextStep: true,
        ),
      ],
    );
  }
}
