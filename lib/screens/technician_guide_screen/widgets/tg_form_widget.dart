import 'package:bpbm2/common/widgets/button_widget.dart';
import 'package:bpbm2/common/widgets/form_container_widget.dart';
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
  final List<TextEditingController> textControllers = [
    TextEditingController(),
    TextEditingController(),
    TextEditingController(),
    TextEditingController(),
    TextEditingController(),
  ];

  @override
  void dispose() {
    for (var textController in textControllers) {
      textController.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FormContainerWidget(
      formWidget: Form(
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
              onSaved: (value) {},
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'لطفا نام خود را وارد نمایید.';
                }
                return null;
              },
              controller: textControllers[0],
              hintText: 'نام*',
            ),
            TextFieldWidget(
              onSaved: (value) {},
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'لطفا نام خانوادگی خود را وارد نمایید.';
                }
                return null;
              },
              controller: textControllers[1],
              hintText: 'نام خانوادگی*',
            ),
            TextFieldWidget(
              onSaved: (value) {},
              textInputType: TextInputType.number,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'لطفا کد ملی خود را وارد نمایید.';
                } else if (value.length != 10) {
                  return 'کد ملی باید 10 رقمی باشد';
                }
                return null;
              },
              controller: textControllers[2],
              hintText: 'کد ملی*',
            ),
            TextFieldWidget(
              onSaved: (value) {},
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
              controller: textControllers[3],
              hintText: 'شماره تلفن همراه*',
              textInputType: TextInputType.number,
            ),
            TextFieldWidget(
              onSaved: (value) {},
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'لطفا پیام خود را وارد نمایید.';
                }
                return null;
              },
              height: 150,
              controller: textControllers[4],
              hintText: 'پیام شما ...*',
            ),
            const SizedBox(
              height: 12.5,
            ),
            ButtonWidget(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  // _formKey.currentState!.save();
                  print(textControllers[2].text);
                }
              },
              text: 'ارسال درخواست همکاری',
              color: Theme.of(context).colorScheme.onPrimary,
              buttonWidth: double.infinity,
            ),
          ],
        ),
      ),
    );
  }
}
