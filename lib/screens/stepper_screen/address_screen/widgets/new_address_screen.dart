import 'package:bpbm2/blocs/address_bloc/address_bloc.dart';
import 'package:bpbm2/screens/stepper_screen/address_screen/widgets/address_status.dart';
import 'package:flutter/material.dart';

class NewAddressScreen extends StatelessWidget {
  final NewAddressSuccess state;
  const NewAddressScreen({super.key, required this.state});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Center(
          child: Text('New Address Screen'),
        ),
        AddressStatus(
          isCurrentAddressScreen: state.currentAddressScreen,
        ),
      ],
    );
  }
}
