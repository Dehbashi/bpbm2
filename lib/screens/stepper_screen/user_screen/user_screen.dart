import 'package:bpbm2/blocs/user_bloc/user_bloc.dart';
import 'package:bpbm2/common/widgets/button_widget.dart';
import 'package:bpbm2/common/widgets/text_field_widget.dart';
import 'package:bpbm2/screens/stepper_screen/user_screen/widgets/user_register_screen.dart';
import 'package:bpbm2/screens/stepper_screen/user_screen/widgets/user_send_otp_screen.dart';
import 'package:bpbm2/screens/stepper_screen/user_screen/widgets/user_send_sms_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UserScreen extends StatelessWidget {
  const UserScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.primary,
        borderRadius: BorderRadius.circular(10),
      ),
      child: BlocBuilder<UserBloc, UserState>(
        builder: (context, state) {
          if (state is UserInitial) {
            return UserSendSmsScreen(
              state: state,
            );
          } else if (state is UserSendSmsSuccess) {
            return UserSendOtpScreen(
              state: state,
            );
          } else if (state is UserSendOtpSuccess) {
            return const UserRegisterScreen();
          } else {
            return Container();
          }
        },
      ),
    );
  }
}
