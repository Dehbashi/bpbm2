import 'package:bpbm2/blocs/address_bloc/address_bloc.dart';
import 'package:bpbm2/common/widgets/button_widget.dart';
import 'package:bpbm2/screens/stepper_screen/address_screen/widgets/address_screen_map_widget.dart';
import 'package:bpbm2/screens/stepper_screen/address_screen/widgets/address_status.dart';
import 'package:bpbm2/screens/stepper_screen/widgets/price_container.dart';
import 'package:bpbm2/screens/stepper_screen/widgets/transportation_price_container.dart';
import 'package:flutter/material.dart';

class NewAddressScreen extends StatelessWidget {
  final AddressBloc bloc;
  final NewAddressSuccess state;
  const NewAddressScreen({
    super.key,
    required this.state,
    required this.bloc,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const PriceContainer(),
        ButtonWidget(
          buttonWidth: double.infinity,
          onPressed: () {
            bloc.add(AddressStarted(context: context));
          },
          text: 'انتخاب نشانی های قبلی',
          icon: const Icon(
            Icons.add_location,
            size: 20,
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        TransportationPriceContainer(
          transportationPrice: state.transportationCost,
        ),
        Text(
          'موقعیت مکانی نشانی را مشخص کنید',
          style: Theme.of(context).textTheme.bodyMedium,
        ),
        AddressScreenMapWidget(
          state: state,
          onPicked: (value) {
            print(value.latLong.latitude);
          },
        ),
        const SizedBox(
          height: 10,
        ),
        AddressStatus(
          isCurrentAddressScreen: state.currentAddressScreen,
        ),
      ],
    );
  }
}
