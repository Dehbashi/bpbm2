import 'package:bpbm2/blocs/auth_bloc/auth_bloc.dart';
import 'package:bpbm2/common/custom_error_messenger.dart';
import 'package:bpbm2/common/widgets/button_widget.dart';
import 'package:bpbm2/screens/profile_screen/profile_drawer/widgets/profile_drawer_header.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';

class DrawerVerifySmsScreen extends StatefulWidget {
  const DrawerVerifySmsScreen({super.key});

  @override
  State<DrawerVerifySmsScreen> createState() => _DrawerVerifySmsScreenState();
}

class _DrawerVerifySmsScreenState extends State<DrawerVerifySmsScreen> {
  String otpCode = '';
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(10, 30, 10, 10),
      child: Column(
        children: [
          const ProfileDrawerHeader(
            icon: Icons.email,
            text: 'اعتبارسنجی',
          ),
          const SizedBox(
            height: 180,
          ),
          Column(
            children: [
              Directionality(
                textDirection: TextDirection.ltr,
                child: OtpTextField(
                  enabledBorderColor:
                      Theme.of(context).colorScheme.onBackground,
                  textStyle: Theme.of(context).textTheme.bodyLarge,
                  numberOfFields: 5,
                  fieldWidth: 50,
                  onSubmit: (value) {
                    otpCode = value;
                  },
                ),
              ),
              const SizedBox(
                height: 70,
              ),
              BlocBuilder<AuthBloc, AuthState>(
                builder: (context, state) {
                  if (state is SendSmsSuccess) {
                    return ButtonWidget(
                      isLoading: state.isLoading,
                      onPressed: () {
                        if (otpCode != '' || otpCode.isNotEmpty) {
                          BlocProvider.of<AuthBloc>(context).add(
                            AuthVerifySms(
                              context,
                              otpCode: otpCode,
                            ),
                          );
                        } else {
                          customErrorMessenger(
                            context: context,
                            message: 'لطفاً کد را درست وارد نمایید',
                          );
                        }
                      },
                      buttonWidth: 200,
                      text: 'بررسی کد فعالسازی',
                    );
                  } else {
                    return Container();
                  }
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
