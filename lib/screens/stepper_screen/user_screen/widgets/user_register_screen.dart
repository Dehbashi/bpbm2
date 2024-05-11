import 'package:bpbm2/blocs/stepper_bloc/stepper_bloc.dart';
import 'package:bpbm2/blocs/user_bloc/user_bloc.dart';
import 'package:bpbm2/common/widgets/button_widget.dart';
import 'package:bpbm2/common/widgets/text_field_widget.dart';
import 'package:bpbm2/screens/stepper_screen/user_screen/widgets/user_register_screen_text_fields.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UserRegisterScreen extends StatefulWidget {
  const UserRegisterScreen({super.key});

  @override
  State<UserRegisterScreen> createState() => _UserRegisterScreenState();
}

class _UserRegisterScreenState extends State<UserRegisterScreen> {
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController _firstNameController = TextEditingController();
  TextEditingController _lastNameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 100, 20, 50),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'مشخصات فردی',
              style: Theme.of(context).textTheme.titleSmall,
            ),
            const SizedBox(
              height: 80,
            ),
            Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  UserRegisterScreenTextFields(
                    controller: _firstNameController,
                    label: 'نام',
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  UserRegisterScreenTextFields(
                    controller: _lastNameController,
                    label: 'نام خانوادگی',
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  Center(
                    child: ButtonWidget(
                      buttonWidth: MediaQuery.of(context).size.width * 0.7,
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          BlocProvider.of<UserBloc>(context).add(
                            RegisterName(
                              firstName: _firstNameController.text,
                              lastName: _lastNameController.text,
                            ),
                          );
                          BlocProvider.of<StepperBloc>(context).add(NextStep());
                        }
                      },
                      text: 'ثبت نام و رفتن به مرحله بعد',
                    ),
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
