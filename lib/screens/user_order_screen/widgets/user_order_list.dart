import 'package:bpbm2/blocs/user_order_bloc/user_order_bloc.dart';
import 'package:bpbm2/common/widgets/button_widget.dart';
import 'package:bpbm2/data/models/order_model/user_order_model.dart';
import 'package:bpbm2/screens/user_order_screen/order_detail_screen.dart';
import 'package:bpbm2/screens/user_order_screen/widgets/order_list_header.dart';
import 'package:bpbm2/screens/user_order_screen/widgets/order_list_info.dart';
import 'package:bpbm2/screens/user_order_screen/widgets/order_list_steps.dart';
import 'package:bpbm2/screens/user_order_screen/widgets/order_list_title.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UserOrderList extends StatelessWidget {
  final List<UserOrderModel> userOrders;
  const UserOrderList({super.key, required this.userOrders});

  @override
  Widget build(BuildContext context) {
    final activeColor = Theme.of(context).colorScheme.onPrimary;
    final inactiveColor = Theme.of(context).colorScheme.onPrimaryContainer;

    return ListView.builder(
      shrinkWrap: true,
      itemCount: userOrders.length,
      itemBuilder: (context, index) {
        Color color;
        final userOrder = userOrders[index];
        return Container(
          margin: const EdgeInsets.fromLTRB(0, 10, 0, 10),
          padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.primary,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              OrderListHeader(userOrder: userOrder),
              const SizedBox(
                height: 10,
              ),
              OrderListTitle(userOrder: userOrder),
              const SizedBox(
                height: 10,
              ),
              OrderListInfo(userOrder: userOrder),
              const SizedBox(
                height: 10,
              ),
              OrderListSteps(
                orderStatus: userOrder.orderStatus,
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  IconButton(
                    onPressed: () {},
                    icon: Icon(
                      Icons.delete_forever,
                      color: Theme.of(context).colorScheme.secondary,
                      size: 30,
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  ButtonWidget(
                    buttonWidth: 160,
                    onPressed: () {
                      // BlocProvider.of<UserOrderBloc>(context).add(
                      //   UserOrderDetail(orderId: userOrder.id),
                      // );
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => BlocProvider(
                            create: (context) => UserOrderBloc(context),
                            child: OrderDetailScreen(
                              orderId: userOrder.id,
                            ),
                          ),
                        ),
                      );
                    },
                    text: 'مشاهده جزئیات',
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
