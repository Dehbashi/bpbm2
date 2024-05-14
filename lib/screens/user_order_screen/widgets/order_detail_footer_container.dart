import 'package:bpbm2/data/models/order_model/order_detail_model.dart';
import 'package:flutter/material.dart';
import 'package:persian_number_utility/persian_number_utility.dart';

class OrderDetailFooterContainer extends StatelessWidget {
  final OrderDetailModel orderDetail;
  const OrderDetailFooterContainer({super.key, required this.orderDetail});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(15),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(9),
          bottomRight: Radius.circular(9),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'جمع کل',
            style: Theme.of(context).textTheme.titleSmall,
          ),
          Text(
            '${orderDetail.totalPrice.toString().toPersianDigit().seRagham()} ریال',
            style: Theme.of(context).textTheme.titleMedium,
          ),
        ],
      ),
    );
  }
}
