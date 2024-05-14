import 'package:bpbm2/common/methods/gregorian_to_shamsi.dart';
import 'package:bpbm2/data/models/order_model/user_order_model.dart';
import 'package:flutter/material.dart';
import 'package:persian_number_utility/persian_number_utility.dart';

class OrderListHeader extends StatelessWidget {
  const OrderListHeader({
    super.key,
    required this.userOrder,
  });

  final UserOrderModel userOrder;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Text(
            'سفارش شماره ${userOrder.id.toString().toPersianDigit()}',
            style: Theme.of(context).textTheme.titleSmall!.copyWith(
                  color: Theme.of(context).colorScheme.inversePrimary,
                ),
          ),
        ),
        Row(
          children: [
            Icon(
              Icons.calendar_today,
              size: 20,
              color: Theme.of(context).colorScheme.onPrimary,
            ),
            const SizedBox(
              width: 10,
            ),
            Text(gregorianToShamsiDateNumber(userOrder.date)),
          ],
        ),
      ],
    );
  }
}