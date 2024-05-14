import 'package:flutter/material.dart';
import 'package:persian_number_utility/persian_number_utility.dart';

class OrderListPriceInfo extends StatelessWidget {
  final String? text;
  final String price;
  final IconData? trIcon;
  const OrderListPriceInfo({
    super.key,
    this.text,
    required this.price,
    this.trIcon,
  });

  @override
  Widget build(BuildContext context) {
    late Color color;
    switch (text) {
      case 'تخفیف':
        color = Theme.of(context).colorScheme.inversePrimary;
        break;
      case 'جمع کل':
        color = Theme.of(context).colorScheme.onPrimary;
        break;
      default:
        color = Theme.of(context).colorScheme.secondaryContainer;
    }
    return Padding(
      padding: const EdgeInsets.only(bottom: 10,top: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          if (text != null)
            Text(
              text!,
              style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    color: color,
                    fontWeight: FontWeight.bold,
                  ),
            ),
          if (trIcon != null)
            Icon(
              trIcon,
              size: 25,
              color: color,
            ),
          Text(price.toPersianDigit().seRagham()),
        ],
      ),
    );
  }
}
