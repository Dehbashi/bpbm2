import 'package:bpbm2/data/models/order_model/user_order_model.dart';
import 'package:flutter/material.dart';

class OrderListTitle extends StatelessWidget {
  const OrderListTitle({
    super.key,
    required this.userOrder,
  });

  final UserOrderModel userOrder;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Image.asset(
          'assets/icons/homeicons/${userOrder.order.service.id}.webp',
          width: 50,
        ),
        const SizedBox(
          width: 20,
        ),
        Text(userOrder.service),
      ],
    );
  }
}