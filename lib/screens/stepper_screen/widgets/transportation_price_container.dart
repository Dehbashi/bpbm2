import 'package:flutter/material.dart';

class TransportationPriceContainer extends StatelessWidget {
  final int transportationPrice;
  const TransportationPriceContainer({
    super.key,
    required this.transportationPrice,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(5,5,5,15),
      padding: const EdgeInsets.all(5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        border: Border.all(
          color: Theme.of(context).colorScheme.secondaryContainer,
          width: 2,
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.airport_shuttle,
            color: Theme.of(context).colorScheme.secondaryContainer,
            size: 25,
          ),
          const SizedBox(
            width: 10,
          ),
          Text(
            '${transportationPrice.toString()} ریال',
            style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                  color: Theme.of(context).colorScheme.secondaryContainer,
                  fontWeight: FontWeight.bold,
                ),
          ),
        ],
      ),
    );
  }
}
