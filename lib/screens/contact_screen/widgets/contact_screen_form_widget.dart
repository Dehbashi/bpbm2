import 'package:bpbm2/common/screen_texts_images/contact_screen_content.dart';
import 'package:bpbm2/common/widgets/button_widget.dart';
import 'package:bpbm2/common/widgets/form_container_widget.dart';
import 'package:bpbm2/common/widgets/text_field_widget.dart';
import 'package:bpbm2/providers/form_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ContactscreenFormWidget extends StatefulWidget {
  const ContactscreenFormWidget({
    super.key,
  });

  @override
  State<ContactscreenFormWidget> createState() =>
      _ContactscreenFormWidgetState();
}

class _ContactscreenFormWidgetState extends State<ContactscreenFormWidget> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final List<TextEditingController> textControllers = [
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
    final provider = Provider.of<FormProvider>(context, listen: false);

    return FormContainerWidget(
      formWidget: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'با ما در میان بگذارید',
              style: Theme.of(context).textTheme.titleSmall,
              textAlign: TextAlign.justify,
            ),
            const SizedBox(
              height: 10,
            ),
            const Text(
              contactParagraph2,
              textAlign: TextAlign.justify,
            ),
            const SizedBox(
              height: 10,
            ),
            TextFieldWidget(
              onSaved: (value) {},
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'لطفا موضوع را وارد نمایید.';
                }
                return null;
              },
              controller: textControllers[0],
              hintText: 'موضوع پیام*',
            ),
            TextFieldWidget(
              onSaved: (value) {},
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'لطفا نام و نام خانوادگی خود را وارد نمایید.';
                }
                return null;
              },
              controller: textControllers[1],
              hintText: 'نام و نام خانوادگی*',
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
              controller: textControllers[2],
              hintText: 'شماره تماس برای پیگیری*',
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
              controller: textControllers[3],
              hintText: 'متن پیامتون رو بنویسید*',
            ),
            const SizedBox(
              height: 12.5,
            ),
            ButtonWidget(
              onPressed: () async {
                if (_formKey.currentState!.validate()) {
                  provider.sendContactForm(
                    context: context,
                    subject: textControllers[0].text,
                    name: textControllers[1].text,
                    cellNumber: textControllers[2].text,
                    text: textControllers[3].text,
                  );
                  for (var textController in textControllers) {
                    textController.clear();
                  }
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
