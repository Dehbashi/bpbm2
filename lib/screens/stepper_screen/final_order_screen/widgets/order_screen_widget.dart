import 'package:bpbm2/blocs/final_order_bloc/final_order_bloc.dart';
import 'package:bpbm2/screens/stepper_screen/final_order_screen/widgets/product_container.dart';
import 'package:bpbm2/screens/stepper_screen/final_order_screen/widgets/service_container.dart';
import 'package:flutter/material.dart';

class OrderScreenWidget extends StatelessWidget {
  final FinalOrderSuccess state;
  final String serviceTitle;
  const OrderScreenWidget({
    super.key,
    required this.state,
    required this.serviceTitle,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ServiceContainer(
          state: state,
          serviceTitle: serviceTitle,
        ),
        if (state.products.isNotEmpty)
          const SizedBox(
            height: 20,
          ),
        if (state.products.isNotEmpty)
          ProductContainer(
            state: state,
          ),
      ],
    );
  }
}
