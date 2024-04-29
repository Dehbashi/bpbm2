import 'package:bpbm2/data/models/service_list/service_detail_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';

class ServiceDetailScreenParagraphWidget extends StatelessWidget {
  const ServiceDetailScreenParagraphWidget({
    super.key,
    required this.serviceDetail,
  });

  final ServiceDetailModel serviceDetail;

  @override
  Widget build(BuildContext context) {
    return HtmlWidget(
      serviceDetail.serviceExp.text,
      customWidgetBuilder: (element) {
        if (element.localName == 'h3' || element.localName == 'h2') {
          return DefaultTextStyle(
            style: Theme.of(context).textTheme.titleSmall!,
            child: Text(element.text),
          );
        } else if (element.localName == 'p') {
          return DefaultTextStyle(
            style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                  height: 1.5,
                ),
            child: Text(element.text),
          );
        } else if (element.localName == 'li') {
          return DefaultTextStyle(
            style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                  height: 2,
                ),
            child: Text(element.text),
          );
        }
      },
    );
  }
}
