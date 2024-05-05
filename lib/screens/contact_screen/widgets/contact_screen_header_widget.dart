import 'package:bpbm2/common/screen_texts_images/contact_screen_content.dart';
import 'package:bpbm2/common/widgets/button_widget.dart';
import 'package:bpbm2/screens/widgets/screen_container_widget.dart';
import 'package:flutter/material.dart';

class ContactScreenHeaderWidget extends StatelessWidget {
  final Function onFaqTapped;
  const ContactScreenHeaderWidget({
    super.key,
    required this.onFaqTapped,
  });

  @override
  Widget build(BuildContext context) {
    return ScreenContainerWidget(
      image: Image.network(contactHeadingImage),
      textWidget: const Text(
        contactParagraph1,
        textAlign: TextAlign.justify,
      ),
      button: ButtonWidget(
        onPressed: () {
          onFaqTapped(3);
        },
        buttonWidth: double.infinity,
        text: 'سوالات پرتکرار',
      ),
    );
  }
}
