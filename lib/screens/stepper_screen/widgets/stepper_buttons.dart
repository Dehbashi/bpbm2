import 'package:bpbm2/blocs/stepper_bloc/stepper_bloc.dart';
import 'package:bpbm2/providers/price_provider.dart';
import 'package:bpbm2/screens/stepper_screen/widgets/stepper_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

class StepperButtons extends StatelessWidget {
  final Function() onNextPressed;
  final Function() onBackPressed;
  const StepperButtons({
    super.key,
    required this.onNextPressed,
    required this.onBackPressed,
  });

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<PriceProvider>(context, listen: false);
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        StepperButton(
          onPressed: onBackPressed,
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
