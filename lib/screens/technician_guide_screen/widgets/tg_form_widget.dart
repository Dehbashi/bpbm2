import 'package:bpbm2/common/widgets/button_widget.dart';
import 'package:bpbm2/common/widgets/text_field_widget.dart';
import 'package:flutter/material.dart';

class TgFormWidget extends StatefulWidget {
  const TgFormWidget({
    super.key,
  });

  @override
  State<TgFormWidget> createState() => _TgFormWidgetState();
}

class _TgFormWidgetState extends State<TgFormWidget> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final Map<String, TextEditingController> textControllers = {
    'firstName': TextEditingController(),
    'lastName': TextEditingController(),
    'cellNumber': TextEditingController(),
    'message': TextEditingController(),
  };

  @override
  void dispose() {
    textControllers.forEach((key, value) {
      value.dispose();
    });
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    String firstName = '';
    String lastName = '';
    String cellNumber = '';
    String message = '';

    return Container(
      padding: const EdgeInsets.fromLTRB(10, 5, 10, 25),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.primary,
        borderRadius: BorderRadius.circular(5),
      ),
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            const SizedBox(
              height: 10,
            ),
            Text(
              'برای همکار شدن با ما همین الان درخواستت رو برامون ارسال کن.',
              style: Theme.of(context).textTheme.bodySmall!.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const SizedBox(
              height: 10,
            ),
            TextFieldWidget(
              onSaved: (value) {
                firstName = textControllers['firstName']!.text;
              },
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'لطفا نام خود را وارد نمایید.';
                }
                return null;
              },
              controller: textControllers['firstName'],
              hintText: 'نام',
            ),
            TextFieldWidget(
              onSaved: (value) {
                lastName = textControllers['lastName']!.text;
              },
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'لطفا نام خانوادگی خود را وارد نمایید.';
                }
                return null;
              },
              controller: textControllers['lastName'],
              hintText: 'نام خانوادگی',
            ),
            TextFieldWidget(
              onSaved: (value) {
                cellNumber = textControllers['cellNumber']!.text;
              },
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'لطفا شماره همراه خود را وارد نمایید.';
                } else if (!value.startsWith('09')) {
                  return 'شماره همراه باید با 09 آغاز شود';
                } else if (value.length != 11) {
                  return 'شماره همراه باید 11 رقمی باشد';
                }
                return null;
              },
              controller: textControllers['cellNumber'],
              hintText: 'شماره تلفن همراه',
              textInputType: TextInputType.number,
            ),
            TextFieldWidget(
              onSaved: (value) {
                message = textControllers['message']!.text;
              },
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'لطفا پیام خود را وارد نمایید.';
                }
                return null;
              },
              height: 150,
              controller: textControllers['message'],
              hintText: 'پیام شما ...',
            ),
            const SizedBox(
              height: 12.5,
            ),
            ButtonWidget(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  _formKey.currentState!.save();
                  print('$firstName $lastName $cellNumber $message');
                }
              },
              text: 'ارسال درخواست همکاری',
              color: Theme.of(context).colorScheme.secondary,
              buttonWidth: double.infinity,
            ),
          ],
        ),
      ),
    );
  }
}
