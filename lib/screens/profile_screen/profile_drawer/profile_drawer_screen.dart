import 'package:bpbm2/blocs/auth_bloc/auth_bloc.dart';
import 'package:bpbm2/screens/profile_screen/profile_drawer/widgets/drawer_send_sms.dart';
import 'package:bpbm2/screens/profile_screen/profile_drawer/widgets/drawer_user_screen.dart';
import 'package:bpbm2/screens/profile_screen/profile_drawer/widgets/drawer_verify_sms_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfileDrawerScreen extends StatefulWidget {
  final GlobalKey<NavigatorState> navKey;
  final GlobalKey<ScaffoldState> scaffoldKey;
  const ProfileDrawerScreen({
    super.key,
    required this.navKey,
    required this.scaffoldKey,
  });

  @override
  State<ProfileDrawerScreen> createState() => _ProfileDrawerScreenState();
}

class _ProfileDrawerScreenState extends State<ProfileDrawerScreen> {
  late AuthBloc bloc;

  @override
  void initState() {
    bloc = BlocProvider.of<AuthBloc>(context);
    bloc.add(AuthStarted());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      width: MediaQuery.of(context).size.width * 0.80,
      child: BlocBuilder<AuthBloc, AuthState>(
        builder: (context, state) {
          if (state is AuthInitial) {
            return const DrawerSendSmsScreen();
          } else if (state is SendSmsSuccess) {
            return const DrawerVerifySmsScreen();
          } else if (state is VerifySmsSuccess) {
            return DrawerUserScreen(
              cellNumber: state.authModel.user.cellNumber,
              navKey: widget.navKey,
              scaffoldKey: widget.scaffoldKey,
            );
          } else if (state is AuthSuccess) {
            return DrawerUserScreen(
              cellNumber: state.user.cellNumber,
              navKey: widget.navKey,
              scaffoldKey: widget.scaffoldKey,
            );
          } else {
            return Container();
          }
        },
      ),
    );
  }
}
