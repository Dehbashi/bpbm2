import 'package:bpbm2/blocs/final_order_bloc/final_order_bloc.dart';
import 'package:bpbm2/screens/stepper_screen/final_order_screen/widgets/final_service_list.dart';
import 'package:flutter/material.dart';
import 'package:persian_number_utility/persian_number_utility.dart';

class ServiceContainer extends StatelessWidget {
  final FinalOrderSuccess state;
  final String serviceTitle;
  const ServiceContainer({
    super.key,
    required this.state,
    required this.serviceTitle,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(0, 0, 0, 10),
      decoration: BoxDecoration(
        border: Border.all(
          color: Theme.of(context).colorScheme.onPrimary,
        ),
        borderRadius: BorderRadius.circular(10),
        color: Theme.of(context).colorScheme.primary,
      ),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.onPrimary,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(5),
                topRight: Radius.circular(5),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  serviceTitle,
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Icon(
                      Icons.location_on,
                      size: 20,
                      color: Colors.white,
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      child: Text(
                        state.address.text,
                        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                              color: Colors.white,
                            ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          ...state.services.map((service) {
            return FinalServiceList(
              service: service,
              userInputs: state.userInputs,
            );
          }),
          Padding(
            padding: const EdgeInsets.only(left: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Icon(
                  Icons.airport_shuttle,
                  color: Theme.of(context).colorScheme.onBackground,
                  size: 20,
                ),
                const SizedBox(
                  width: 10,
                ),
                Text(
                  '${state.transportationCost.toString().toPersianDigit().seRagham()} ریال',
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 15,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'جمع کل: ${(state.priceOfServices + state.transportationCost).toString().toPersianDigit().seRagham()} ریال',
                style: Theme.of(context).textTheme.titleSmall!.copyWith(
                      color: Theme.of(context).colorScheme.secondaryContainer,
                    ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
