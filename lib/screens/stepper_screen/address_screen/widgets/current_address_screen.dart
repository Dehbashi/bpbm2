import 'package:bpbm2/blocs/address_bloc/address_bloc.dart';
import 'package:bpbm2/blocs/stepper_bloc/stepper_bloc.dart';
import 'package:bpbm2/common/constants.dart';
import 'package:bpbm2/common/custom_error_messenger.dart';
import 'package:bpbm2/common/widgets/button_widget.dart';
import 'package:bpbm2/data/repo/auth_repository.dart';
import 'package:bpbm2/providers/price_provider.dart';
import 'package:bpbm2/screens/stepper_screen/address_screen/widgets/address_status.dart';
import 'package:bpbm2/screens/stepper_screen/widgets/price_container.dart';
import 'package:bpbm2/screens/stepper_screen/widgets/stepper_buttons.dart';
import 'package:bpbm2/screens/stepper_screen/widgets/transportation_price_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

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
    int selectedOption = state.isFirstTime ? -1 : selectedAddress;
    final provider = Provider.of<PriceProvider>(context, listen: false);
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const PriceContainer(),
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
                      offset: const Offset(0, 1.5),
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
                  groupValue: selectedOption,
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
        const SizedBox(
          height: 10,
        ),
        StepperButtons(
          onNextPressed: () {
            if (AuthRepository.authChangeNotifier.value != null) {
              if (selectedAddress != -1) {
                provider.addItem(price: state.transportationCost);
                BlocProvider.of<StepperBloc>(context).add(NextStep());
              } else {
                customErrorMessenger(
                  context: context,
                  message: 'لطفاً یک گزینه را انتخاب نمایید',
                );
              }
            } else {
              customErrorMessenger(
                context: context,
                message: 'لطفاً یک آدرس جدید انتخاب نمایید',
              );
            }
          },
        ),
      ],
    );
  }
}
