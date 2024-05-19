import 'package:bpbm2/blocs/final_order_bloc/final_order_bloc.dart';
import 'package:bpbm2/screens/stepper_screen/final_order_screen/widgets/order_screen_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FinalOrderScreen extends StatelessWidget {
  final String serviceTitle;
  final int serviceId;
  const FinalOrderScreen({
    super.key,
    required this.serviceTitle,
    required this.serviceId,
  });

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<FinalOrderBloc>(context).add(FinalOrderStarted());

    return SingleChildScrollView(
      child: Column(
        children: [
          Text(
            'بررسی و تأیید سفارش',
            style: Theme.of(context).textTheme.titleSmall,
          ),
          const SizedBox(
            height: 10,
          ),
          BlocBuilder<FinalOrderBloc, FinalOrderState>(
            builder: (context, state) {
              if (state is FinalOrderFailed) {
                return const Center(
                  child: Text('خطای نامشخص'),
                );
              } else if (state is FinalOrderSuccess) {
                return OrderScreenWidget(
                  state: state,
                  serviceTitle: serviceTitle,
                  serviceId: serviceId,
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
