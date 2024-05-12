import 'package:bpbm2/blocs/address_bloc/address_bloc.dart';
import 'package:bpbm2/blocs/final_order_bloc/final_order_bloc.dart';
import 'package:bpbm2/blocs/question_bloc/question_bloc.dart';
import 'package:bpbm2/blocs/stepper_bloc/stepper_bloc.dart';
import 'package:bpbm2/blocs/time_bloc/time_bloc.dart';
import 'package:bpbm2/blocs/user_bloc/user_bloc.dart';
import 'package:bpbm2/providers/price_provider.dart';
import 'package:bpbm2/screens/stepper_screen/address_screen/address_screen.dart';
import 'package:bpbm2/screens/stepper_screen/final_order_screen/final_order_screen.dart';
import 'package:bpbm2/screens/stepper_screen/final_step_screen/final_step_screen.dart';
import 'package:bpbm2/screens/stepper_screen/question_screen/question_screen.dart';
import 'package:bpbm2/screens/stepper_screen/time_screen/time_screen.dart';
import 'package:bpbm2/screens/stepper_screen/user_screen/user_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

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
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => PriceProvider()),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider(create: (context) => QuestionBloc()),
          BlocProvider(create: (context) => AddressBloc(context)),
          BlocProvider(create: (context) => TimeBloc(context)),
          BlocProvider(create: (context) => UserBloc(context)),
          BlocProvider(create: (context) => FinalOrderBloc(context)),
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
              } else if (state is TimeScreenSuccess) {
                return const TimeScreen();
              } else if (state is UserScreenSuccess) {
                return const UserScreen();
              } else if (state is FinalOrderScreenSuccess) {
                return FinalOrderScreen(
                  serviceTitle: serviceTitle,
                );
              } else if (state is FinalStepScreenSuccess) {
                return const FinalStepScreen();
              } else {
                return Container();
              }
            },
          ),
        ),
      ),
    );
  }
}
