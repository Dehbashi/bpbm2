import 'package:bpbm2/blocs/final_order_bloc/final_order_bloc.dart';
import 'package:bpbm2/blocs/stepper_bloc/stepper_bloc.dart';
import 'package:bpbm2/screens/stepper_screen/final_order_screen/widgets/discount_widget.dart';
import 'package:bpbm2/screens/stepper_screen/final_order_screen/widgets/discription_box.dart';
import 'package:bpbm2/screens/stepper_screen/final_order_screen/widgets/product_container.dart';
import 'package:bpbm2/screens/stepper_screen/final_order_screen/widgets/service_container.dart';
import 'package:bpbm2/screens/stepper_screen/widgets/stepper_buttons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:persian_number_utility/persian_number_utility.dart';

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
    TextEditingController _discriptionController = TextEditingController();

    return Column(
      children: [
        ServiceContainer(
          state: state,
          serviceTitle: serviceTitle,
        ),
        const SizedBox(
          height: 20,
        ),
        DiscountWidget(state: state),
        const SizedBox(
          height: 20,
        ),
        if (state.products.isNotEmpty)
          const SizedBox(
            height: 20,
          ),
        if (state.products.isNotEmpty)
          ProductContainer(
            state: state,
          ),
        Text(
          'جمع نهایی: ${state.totalPrice.toString().toPersianDigit().seRagham()} ریال',
          style: Theme.of(context).textTheme.titleSmall!.copyWith(
                color: Theme.of(context).colorScheme.inversePrimary,
              ),
        ),
        const SizedBox(
          height: 20,
        ),
        DiscriptionBox(
          controller: _discriptionController,
        ),
        const SizedBox(
          height: 20,
        ),
        StepperButtons(
          onNextPressed: () {
            BlocProvider.of<StepperBloc>(context).add(NextStep());
          },
          onBackPressed: () {
            BlocProvider.of<StepperBloc>(context).add(PreviousStep());
          },
        ),
      ],
    );
  }
}
