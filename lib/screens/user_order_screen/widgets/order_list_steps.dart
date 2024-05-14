import 'package:flutter/material.dart';

class OrderListSteps extends StatelessWidget {
  final int orderStatus;
  const OrderListSteps({
    super.key,
    required this.orderStatus,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        OrderListStep(
          step: 'تایید اولیه',
          active: orderStatus >= 0 ? true : false,
        ),
        OrderListStep(
          step: 'سرویسکار مشخص شد',
          active: orderStatus >= 4 ? true : false,
        ),
        OrderListStep(
          step: 'سرویسکار در حال حرکت به سمت شماست',
          active: orderStatus >= 5 ? true : false,
        ),
        OrderListStep(
          step: 'سفارش با موفقیت انجام شد',
          active: orderStatus == 11 ? true : false,
        ),
      ],
    );
  }
}

class OrderListStep extends StatelessWidget {
  final String step;
  final bool active;
  const OrderListStep({
    super.key,
    required this.step,
    required this.active,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: Row(
        children: [
          Icon(
            Icons.check_circle,
            size: 30,
            color: active
                ? Theme.of(context).colorScheme.onPrimary
                : Theme.of(context).colorScheme.onPrimaryContainer,
          ),
          const SizedBox(
            width: 5,
          ),
          Text(step)
        ],
      ),
    );
  }
}
