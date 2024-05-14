import 'package:bpbm2/data/models/order_model/user_order_model.dart';
import 'package:bpbm2/screens/user_order_screen/widgets/order_list_price_info.dart';
import 'package:flutter/material.dart';
import 'package:persian_number_utility/persian_number_utility.dart';

class OrderListInfo extends StatelessWidget {
  final UserOrderModel userOrder;

  const OrderListInfo({
    super.key,
    required this.userOrder,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Flexible(
          flex: 6,
          child: Padding(
            padding: const EdgeInsets.all(5),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Row(
                  children: [
                    const Icon(
                      Icons.location_on,
                      size: 20,
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      child: Text(
                        userOrder.address.text,
                        maxLines: null,
                      ),
                    ),
                  ],
                ),
                OrderListPriceInfo(
                  price: userOrder.order.discount,
                  text: 'تخفیف',
                ),
                OrderListPriceInfo(
                  trIcon: Icons.airport_shuttle,
                  price: userOrder.order.transportationCost,
                ),
                OrderListPriceInfo(
                  price: userOrder.order.totalPrice,
                  text: 'جمع کل',
                ),
              ],
            ),
          ),
        ),
        Flexible(
          flex: 4,
          child: Container(
            padding: const EdgeInsets.all(5),
            margin: const EdgeInsets.all(5),
            height: 200,
            decoration: BoxDecoration(
              border: Border.all(
                color: Theme.of(context).colorScheme.onPrimary,
              ),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Column(
              children: [
                CircleAvatar(
                  radius: 50,
                  backgroundColor: Colors.yellow.shade700,
                ),
                Text('سرویسکار'),
                Text(userOrder.servicer != null
                    ? userOrder.servicer!.user.name
                    : ''),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
