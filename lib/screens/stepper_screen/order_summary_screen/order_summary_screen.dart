import 'package:bpbm2/blocs/stepper_bloc/stepper_bloc.dart';
import 'package:bpbm2/screens/stepper_screen/widgets/stepper_buttons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OrderSummaryScreen extends StatelessWidget {
  const OrderSummaryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Center(
          child: Text('Order Summary Screen'),
        ),
        StepperButtons(
          onNextPressed: () {},
          onBackPressed: () {
            BlocProvider.of<StepperBloc>(context).add(PreviousStep());
          },
        ),
      ],
    );
  }
}
