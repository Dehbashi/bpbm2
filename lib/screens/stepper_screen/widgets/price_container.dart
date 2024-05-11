import 'package:bpbm2/common/dialogs/generic_dialog.dart';
import 'package:bpbm2/providers/price_provider.dart';
import 'package:flutter/material.dart';
import 'package:persian/persian.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import  'package:persian_number_utility/persian_number_utility.dart';

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
                      '${value.newPrice.toString().toPersianDigit().seRagham()} ریال',
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.surface,
                      ),
                    ),
                  ],
                ),
              ),
              IconButton(
                onPressed: () {
                  showGenericDialog(
                    context: context,
                    title: 'حذف اطلاعات سفارش',
                    content: 'آیا از از حذف اطلاعات سفارش اطمینان دارید؟',
                    optionsBuilder: () => {
                      'خیر': false,
                      'بله': true,
                    },
                  ).then((response) async {
                    if (response != null && response) {
                      SharedPreferences prefs =
                          await SharedPreferences.getInstance();
                          prefs.remove('selectedQuestions');
                          prefs.remove('userInputs');
                      final provider =
                          Provider.of<PriceProvider>(context, listen: false);
                      provider.clearPrice();
                      Navigator.of(context).pop();
                    }
                  });
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
