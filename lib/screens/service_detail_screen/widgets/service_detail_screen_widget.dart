import 'dart:convert';

import 'package:bpbm2/common/constants.dart';
import 'package:bpbm2/data/models/service_list/service_detail_model.dart';
import 'package:bpbm2/screens/service_detail_screen/widgets/service_detail_screen_paragraph_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';

class ServiceDetailScreenWidget extends StatelessWidget {
  final ServiceDetailModel serviceDetail;
  const ServiceDetailScreenWidget({
    super.key,
    required this.serviceDetail,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(20, 10, 20, 5),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'آشنایی با سرویس ${utf8.decode(serviceDetail.serviceExp.title.codeUnits)}',
              style: Theme.of(context).textTheme.titleSmall,
            ),
            const SizedBox(
              height: 10,
            ),
            Image.network(
              '$baseAssetUrl/${serviceDetail.serviceExp.id}/header.png',
            ),
            const SizedBox(
              height: 10,
            ),
            ServiceDetailScreenParagraphWidget(serviceDetail: serviceDetail),
            const SizedBox(
              height: 10,
            ),
            if (serviceDetail.serviceFaqs.isNotEmpty)
              Text(
                'سوالات متدوال',
                style: Theme.of(context).textTheme.titleSmall,
              ),
            if (serviceDetail.serviceFaqs.isNotEmpty)
              ...serviceDetail.serviceFaqs.map((faq) {
                return Column(
                  children: [
                    Text(utf8.decode(faq.title.codeUnits)),
                    Text(utf8.decode(faq.text.codeUnits)),
                  ],
                );
              }).toList()
          ],
        ),
      ),
    );
  }
}
