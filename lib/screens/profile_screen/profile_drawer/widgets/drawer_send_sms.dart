import 'package:bpbm2/blocs/auth_bloc/auth_bloc.dart';
import 'package:bpbm2/common/widgets/button_widget.dart';
import 'package:bpbm2/common/widgets/text_field_widget.dart';
import 'package:bpbm2/screens/profile_screen/profile_drawer/widgets/profile_drawer_header.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DrawerSendSmsScreen extends StatefulWidget {
  const DrawerSendSmsScreen({super.key});

  @override
  State<DrawerSendSmsScreen> createState() => _DrawerSendSmsScreenState();
}

class _DrawerSendSmsScreenState extends State<DrawerSendSmsScreen> {
  TextEditingController smsController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    smsController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(10, 30, 10, 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const ProfileDrawerHeader(
            icon: Icons.lock,
            text: 'ورود کاربر',
          ),
          const SizedBox(
            height: 40,
          ),
          const Padding(
            padding: EdgeInsets.fromLTRB(15, 10, 15, 10),
            child: Text(
              'کاربر گرامی!\n'
              'به سامانه بسپارش به ما خوش آمدید!\n'
              'شماره تلفن همراه خود را با قرار دادن صفحه کلید روی زبان انگلیسی وارد کنید.',
              textAlign: TextAlign.justify,
            ),
          ),
          const SizedBox(
            height: 40,
          ),
          Form(
            key: _formKey,
            child: Column(
              children: [
                TextFieldWidget(
                  controller: smsController,
                  textInputType: TextInputType.number,
                  onSaved: (value) {},
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'لطفاً شماره تلفن خود را وارد نمایید';
                    } else if (!value.startsWith('09')) {
                      return 'شماره تلفن باید با 09 آغاز شود';
                    } else if (value.length != 11) {
                      return 'شماره تلفن باید 11 رقمی باشد';
                    } else {
                      return null;
                    }
                  },
                  hintText: 'شماره تلفن همراه',
                ),
                const SizedBox(
                  height: 40,
                ),
                BlocBuilder<AuthBloc, AuthState>(
                  builder: (context, state) {
                    if (state is AuthInitial) {
                      return ButtonWidget(
                        isLoading: state.isLoading,
                        buttonWidth: 200,
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            BlocProvider.of<AuthBloc>(context).add(
                              AuthSendSms(
                                context,
                                cellNumber: smsController.text,
                              ),
                            );
                          }
                        },
                        text: 'ارسال کد فعالسازی',
                      );
                    } else {
                      return Container();
                    }
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
