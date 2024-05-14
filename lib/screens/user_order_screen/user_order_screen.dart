import 'package:bpbm2/blocs/user_order_bloc/user_order_bloc.dart';
import 'package:bpbm2/screens/user_order_screen/widgets/user_order_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UserOrderScreen extends StatelessWidget {
  const UserOrderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<UserOrderBloc>(context).add(UserOrderStarted());
    
    return Padding(
      padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
      child: Column(
        children: [
          Text(
            'سفارش های من',
            style: Theme.of(context).textTheme.titleSmall,
          ),
          const Divider(),
          BlocBuilder<UserOrderBloc, UserOrderState>(
            builder: (context, state) {
              if (state is UserOrderFailed) {
                return const Center(
                  child: Text('خطا در بارگذاری اطلاعات'),
                );
              } else if (state is UserOrderEmpty) {
                return Center(
                  child: Text(state.message),
                );
              } else if (state is UserOrderSuccess) {
                return Expanded(
                  child: UserOrderList(
                    userOrders: state.userOrders,
                  ),
                );
              } else {
                return Container();
              }
            },
          ),
        ],
      ),
    );
  }
}
