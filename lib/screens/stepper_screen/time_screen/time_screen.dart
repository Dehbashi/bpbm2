import 'package:bpbm2/screens/stepper_screen/widgets/price_container.dart';
import 'package:bpbm2/screens/stepper_screen/widgets/stepper_buttons.dart';
import 'package:flutter/material.dart';

class TimeScreen extends StatelessWidget {
  const TimeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const PriceContainer(),
        StepperButtons(
          onNextPressed: () {},
        ),
      ],
    );
  }
}
