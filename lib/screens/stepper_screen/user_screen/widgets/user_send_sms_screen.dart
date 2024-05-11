import 'package:bpbm2/blocs/user_bloc/user_bloc.dart';
import 'package:bpbm2/common/widgets/button_widget.dart';
import 'package:bpbm2/common/widgets/text_field_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UserSendSmsScreen extends StatefulWidget {
  final UserInitial state;
  const UserSendSmsScreen({super.key, required this.state});

  @override
  State<UserSendSmsScreen> createState() => _UserSendSmsScreenState();
}

class _UserSendSmsScreenState extends State<UserSendSmsScreen> {
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController _controller = TextEditingController();
  late UserBloc bloc;

  @override
  void initState() {
    bloc = BlocProvider.of<UserBloc>(context);
    bloc.add(UserStarted());
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/images/logo.png',
              width: 200,
            ),
            const SizedBox(
              height: 50,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.phonelink_lock,
                  color: Theme.of(context).colorScheme.onPrimary,
                  size: 30,
                ),
                Text(
                  'شماره تلفن همراهتون رو وارد کنید',
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      TextFieldWidget(
                        width: MediaQuery.of(context).size.width * 0.5,
                        controller: _controller,
                        textInputType: TextInputType.number,
                        onSaved: (value) {},
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'لطفاً شماره همراه خود را وارد نمایید';
                          } else if (value!.length != 11) {
                            return 'شماره تلفن باید 11 رقمی باشد';
                          } else if (!value.startsWith('09')) {
                            return 'شماره تلفن باید با 09 آغاز شود';
                          }
                          return null;
                        },
                        hintText: '09123456789',
                      ),
                      IconButton(
                        icon: Icon(
                          Icons.refresh,
                          size: 30,
                          color: Theme.of(context).colorScheme.onPrimaryContainer,
                        ),
                        onPressed: () {
                          setState(() {
                            _controller.clear();
                          });
                        },
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  ButtonWidget(
                    isLoading: widget.state.isLoading,
                    buttonWidth: MediaQuery.of(context).size.width * 0.7,
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        bloc.add(SendSms(cellNumber: _controller.text));
                      }
                    },
                    text: 'ارسال کد فعالسازی',
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
