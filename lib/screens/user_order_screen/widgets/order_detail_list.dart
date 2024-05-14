import 'package:bpbm2/common/constants.dart';
import 'package:bpbm2/data/models/order_model/order_detail_model.dart';
import 'package:flutter/material.dart';
import 'package:persian_number_utility/persian_number_utility.dart';

class OrderDetailList extends StatelessWidget {
  final OrderDetailModel orderDetail;
  const OrderDetailList({super.key, required this.orderDetail});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: SingleChildScrollView(
        physics: defaultScrollPhysics,
        child: Column(
          children: [
            ...orderDetail.items.map(
              (item) {
                bool isService;
                switch (item.type) {
                  case 'service':
                    isService = true;
                    break;
                  case 'product':
                    isService = false;
                    break;
                  default:
                    isService = true;
                }
                return Container(
                  margin: const EdgeInsets.all(10),
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    border: Border(
                      bottom: BorderSide(
                        color: Theme.of(context).colorScheme.onPrimary,
                      ),
                    ),
                  ),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Icon(
                            Icons.comment,
                            color: Theme.of(context).colorScheme.onPrimary,
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Expanded(
                            child: Text(
                              item.title,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          Icon(
                            Icons.arrow_forward,
                            color: Theme.of(context).colorScheme.onPrimary,
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Expanded(
                            child: Text(
                              '${item.value} ${isService ? '' : '(${item.number.toString().toPersianDigit()} عدد)'}',
                            ),
                          ),
                          Text(
                            '${item.price.toString().toPersianDigit().seRagham()} ریال',
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              },
            ),
            const SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 0, 0, 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Icon(
                    Icons.airport_shuttle,
                    color: Theme.of(context).colorScheme.onPrimary,
                    size: 30,
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Text(
                    '${orderDetail.transportationCost.toString().toPersianDigit().seRagham()} ریال',
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
