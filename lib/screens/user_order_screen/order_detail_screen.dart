import 'package:bpbm2/blocs/user_order_bloc/user_order_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OrderDetailScreen extends StatelessWidget {
  final int orderId;
  const OrderDetailScreen({
    super.key,
    required this.orderId,
  });

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<UserOrderBloc>(context).add(
      UserOrderDetail(orderId: orderId),
    );
    return BlocBuilder<UserOrderBloc, UserOrderState>(
      builder: (context, state) {
        if (state is UserOrderDetailFailed) {
          return const Center(
            child: Text('خطا در بارگذاری اطلاعات'),
          );
        } else if (state is UserOrderDetailSuccess) {
          return Center(
            child: Text(
              state.orderDetail.id.toString(),
            ),
          );
        } else {
          return Container();
        }
      },
    );
  }
}
