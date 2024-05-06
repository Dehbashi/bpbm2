import 'package:bpbm2/blocs/stepper_bloc/stepper_bloc.dart';
import 'package:bpbm2/common/widgets/button_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddressScreen extends StatelessWidget {
  const AddressScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            ButtonWidget(
              onPressed: () {
                BlocProvider.of<StepperBloc>(context).add(PreviousStep());
              },
              text: 'مرحله قبل',
            ),
          ],
        ),
      ],
    );
  }
}
