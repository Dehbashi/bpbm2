import 'package:bpbm2/blocs/address_bloc/address_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddressStatus extends StatelessWidget {
  final bool isCurrentAddressScreen;
  const AddressStatus({super.key, required this.isCurrentAddressScreen});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        AddressScreenStatusButton(
          isCurrentAddressScreen: isCurrentAddressScreen,
          onTap: () {
            BlocProvider.of<AddressBloc>(context).add(
              AddressStarted(context: context),
            );
          },
        ),
        const SizedBox(
          width: 10,
        ),
        AddressScreenStatusButton(
          isCurrentAddressScreen: !isCurrentAddressScreen,
          onTap: () {
            BlocProvider.of<AddressBloc>(context).add(
              NewAddressStarted(context: context),
            );
          },
        )
      ],
    );
  }
}

class AddressScreenStatusButton extends StatelessWidget {
  const AddressScreenStatusButton({
    super.key,
    required this.isCurrentAddressScreen,
    required this.onTap,
  });

  final bool isCurrentAddressScreen;
  final Function() onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(10),
      child: Container(
        width: 20,
        height: 20,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          color: isCurrentAddressScreen
              ? Theme.of(context).colorScheme.onBackground
              : Theme.of(context).colorScheme.primary,
        ),
      ),
    );
  }
}
