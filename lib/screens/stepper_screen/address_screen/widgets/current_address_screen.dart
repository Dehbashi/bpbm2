import 'package:bpbm2/blocs/address_bloc/address_bloc.dart';
import 'package:bpbm2/common/constants.dart';
import 'package:bpbm2/common/widgets/button_widget.dart';
import 'package:bpbm2/screens/stepper_screen/address_screen/widgets/address_status.dart';
import 'package:bpbm2/screens/stepper_screen/widgets/price_container.dart';
import 'package:bpbm2/screens/stepper_screen/widgets/transportation_price_container.dart';
import 'package:flutter/material.dart';

class CurrentAddressScreeen extends StatelessWidget {
  final AddressBloc bloc;
  final CurrentAddressSuccess state;
  final int selectedAddress;
  final void Function(int?) selectRadioButton;
  const CurrentAddressScreeen({
    super.key,
    required this.bloc,
    required this.state,
    required this.selectedAddress,
    required this.selectRadioButton,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const PriceContainer(price: 10000),
        ButtonWidget(
          buttonWidth: double.infinity,
          onPressed: () {
            bloc.add(NewAddressStarted(context: context));
          },
          text: 'افزدون نشانی جدید',
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
          'نشانی های ثبت شده قبلی',
          style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                fontWeight: FontWeight.bold,
              ),
        ),
        const SizedBox(
          height: 10,
        ),
        if (state.addresses.isEmpty)
          Center(
            child: Text(state.emptyMessage!),
          ),
        if (state.addresses.isNotEmpty)
          ListView.builder(
            physics: defaultScrollPhysics,
            shrinkWrap: true,
            itemCount: state.addresses.length,
            itemBuilder: (context, index) {
              final address = state.addresses[index];
              return Container(
                padding: const EdgeInsets.fromLTRB(5, 5, 5, 5),
                margin: const EdgeInsets.fromLTRB(5, 5, 5, 5),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.primary,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      blurRadius: 1,
                      color: Theme.of(context).colorScheme.shadow,
                      spreadRadius: 1,
                      offset: Offset(0, 1.5),
                    )
                  ],
                ),
                child: RadioListTile(
                  title: Text(
                    address.text,
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  fillColor: MaterialStateProperty.all(
                    Theme.of(context).colorScheme.onBackground,
                  ),
                  shape: BeveledRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  value: address.id,
                  groupValue: selectedAddress,
                  onChanged: (value) {
                    bloc.add(
                      CurrentAddressSelected(
                        context: context,
                        address: address,
                        addresses: state.addresses,
                      ),
                    );
                    selectRadioButton(value);
                  },
                ),
              );
            },
          ),
        const SizedBox(
          height: 20,
        ),
        AddressStatus(
          isCurrentAddressScreen: state.currentAddressScreen,
        ),
      ],
    );
  }
}
