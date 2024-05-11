import 'package:bpbm2/blocs/final_order_bloc/final_order_bloc.dart';
import 'package:flutter/material.dart';

class ServiceContainer extends StatelessWidget {
  final FinalOrderSuccess state;
  final String serviceTitle;
  const ServiceContainer(
      {super.key, required this.state, required this.serviceTitle});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(5, 20, 5, 10),
      decoration: BoxDecoration(
        border: Border.all(
          color: Theme.of(context).colorScheme.primary,
        ),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.onPrimary,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(10),
                topRight: Radius.circular(10),
              ),
            ),
            child: Column(
              children: [
                Text(
                  serviceTitle,
                  style: Theme.of(context).textTheme.titleSmall!.copyWith(
                        color: Colors.white,
                      ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    const Icon(
                      Icons.location_on,
                      size: 20,
                      color: Colors.white,
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Text(
                      state.address.text,
                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                            color: Colors.white,
                          ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
