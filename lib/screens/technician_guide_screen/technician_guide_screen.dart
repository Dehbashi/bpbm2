import 'package:bpbm2/common/screen_texts_images/technician_guide_screen_content.dart';
import 'package:bpbm2/screens/technician_guide_screen/widgets/tg_header_title.dart';
import 'package:bpbm2/screens/technician_guide_screen/widgets/tg_item_widget.dart';
import 'package:flutter/material.dart';

class TechnicianGuideScreen extends StatelessWidget {
  const TechnicianGuideScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const TgHeaderTitle(),
            const SizedBox(
              height: 10,
            ),
            Text(
              tgHeaderText,
              style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const SizedBox(
              height: 10,
            ),
            Image.network(tgHeaderImage),
            const SizedBox(
              height: 10,
            ),
            const Text(
              tgParagraph1,
              textAlign: TextAlign.justify,
            ),
            const SizedBox(
              height: 20,
            ),
            ...tgItems.map((tgItem) {
              return TgItemWidget(tgItem: tgItem);
            }),
          ],
        ),
      ),
    );
  }
}
