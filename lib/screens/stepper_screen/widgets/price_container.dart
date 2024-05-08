import 'package:bpbm2/providers/price_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PriceContainer extends StatelessWidget {
  const PriceContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<PriceProvider>(
      builder: (context, value, child) {
        return Container(
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.inversePrimary,
            borderRadius: BorderRadius.circular(10),
          ),
          padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
          margin: const EdgeInsets.fromLTRB(15, 15, 15, 15),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  children: [
                    Text(
                      'هزینه محاسبه شده تا این لحظه',
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.surface,
                      ),
                    ),
                    Text(
                      '${value.newPrice} ریال',
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.surface,
                      ),
                    ),
                  ],
                ),
              ),
              IconButton(
                onPressed: () {
                  final provider = Provider.of<PriceProvider>(context, listen: false);
                  provider.clearPrice();
                },
                icon: Icon(
                  Icons.refresh,
                  color: Theme.of(context).colorScheme.surface,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
