import 'package:bpbm2/blocs/auth_bloc/auth_bloc.dart';
import 'package:bpbm2/screens/profile_screen/profile_drawer/widgets/drawer_send_sms.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfileDrawerScreen extends StatelessWidget {
  const ProfileDrawerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<AuthBloc>(context).add(AuthStarted());
    return Drawer(
      width: MediaQuery.of(context).size.width * 0.80,
      child: BlocBuilder<AuthBloc, AuthState>(
        builder: (context, state) {
          if (state is AuthInitial) {
            return const DrawerSendSmsScreen();
          } else {
            return Container();
          }
        },
      ),
    );
  }
}
