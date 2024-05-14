import 'package:bpbm2/common/constants.dart';
import 'package:bpbm2/data/models/order_model/order_detail_model.dart';
import 'package:bpbm2/screens/user_order_screen/widgets/order_detail_footer_container.dart';
import 'package:bpbm2/screens/user_order_screen/widgets/order_detail_header_container.dart';
import 'package:bpbm2/screens/user_order_screen/widgets/order_detail_list.dart';
import 'package:flutter/material.dart';
import 'package:persian_number_utility/persian_number_utility.dart';

class OrderDetailContainer extends StatelessWidget {
  final OrderDetailModel orderDetail;
  const OrderDetailContainer({super.key, required this.orderDetail});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.primary,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: Theme.of(context).colorScheme.onPrimary,
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          OrderDetailHeaderContainer(orderDetail: orderDetail),
          OrderDetailList(orderDetail: orderDetail),
          OrderDetailFooterContainer(orderDetail: orderDetail),
        ],
      ),
    );
  }
}
