import 'package:bpbm2/blocs/question_bloc/question_bloc.dart';
import 'package:bpbm2/blocs/stepper_bloc/stepper_bloc.dart';
import 'package:bpbm2/screens/stepper_screen/address_screen/address_screen.dart';
import 'package:bpbm2/screens/stepper_screen/question_screen/question_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class StepperScreen extends StatelessWidget {
  final String serviceTitle;
  final int serviceId;
  const StepperScreen({
    super.key,
    required this.serviceTitle,
    required this.serviceId,
  });

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<StepperBloc>(context).add(StepperStarted());
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => QuestionBloc(),
        ),
      ],
      child: Padding(
        padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
        child: BlocBuilder<StepperBloc, StepperState>(
          builder: (context, state) {
            if (state is QuestionScreenSuccess) {
              return QuestionScreen(
                serviceId: serviceId,
                serviceTitle: serviceTitle,
              );
            } else if (state is AddressScreenSuccess) {
              return const AddressScreen();
            } else {
              return Container();
            }
          },
        ),
      ),
    );
  }
}
