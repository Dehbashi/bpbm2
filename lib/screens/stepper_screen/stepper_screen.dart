import 'package:bpbm2/blocs/question_bloc/question_bloc.dart';
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
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => QuestionBloc(),
        ),
      ],
      child: Padding(
        padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
        child: QuestionScreen(
          serviceId: serviceId,
          serviceTitle: serviceTitle,
        ),
      ),
    );
  }
}
