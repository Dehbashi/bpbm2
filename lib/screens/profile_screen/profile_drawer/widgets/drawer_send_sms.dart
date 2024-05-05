import 'package:bpbm2/blocs/auth_bloc/auth_bloc.dart';
import 'package:bpbm2/common/widgets/button_widget.dart';
import 'package:bpbm2/common/widgets/text_field_widget.dart';
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
          Image.asset(
            'assets/images/logo.png',
            width: 150,
          ),
          const SizedBox(
            height: 15,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.lock,
                size: 30,
                color: Theme.of(context).colorScheme.onBackground,
              ),
              Text(
                'ورود کاربر',
                style: Theme.of(context).textTheme.titleSmall,
              ),
            ],
          ),
          const SizedBox(height: 40,),
          const Text(
            'کاربر گرامی!\n'
            'به سامانه بسپارش به ما خوش آمدید!\n'
            'شماره تلفن همراه خود را با قرار دادن صفحه کلید روی زبان انگلیسی وارد کنید.',
            textAlign: TextAlign.justify,
          ),
          const SizedBox(height: 40,),
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
                const SizedBox(height: 40,),
                ButtonWidget(
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
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
