import 'package:bpbm2/screens/contact_screen/widgets/contact_screen_address_widget.dart';
import 'package:bpbm2/screens/contact_screen/widgets/contact_screen_form_widget.dart';
import 'package:bpbm2/screens/contact_screen/widgets/contact_screen_header_widget.dart';
import 'package:flutter/material.dart';

class ContactScreen extends StatelessWidget {
  final ScrollController scrollController;
  final Function onFaqTapped;
  const ContactScreen({
    super.key,
    required this.scrollController,
    required this.onFaqTapped,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
      child: SingleChildScrollView(
        controller: scrollController,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'تماس با بسپارش به ما',
              style: Theme.of(context).textTheme.titleSmall,
            ),
            ContactScreenHeaderWidget(onFaqTapped: onFaqTapped),
            const ContactScreenAddressWidget(),
            const ContactscreenFormWidget(),
          ],
        ),
      ),
    );
  }
}
