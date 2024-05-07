import 'package:bpbm2/blocs/address_bloc/address_bloc.dart';
import 'package:bpbm2/common/widgets/button_widget.dart';
import 'package:bpbm2/screens/stepper_screen/widgets/price_container.dart';
import 'package:bpbm2/screens/stepper_screen/widgets/transportation_price_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddressScreen extends StatefulWidget {
  const AddressScreen({super.key});

  @override
  State<AddressScreen> createState() => _AddressScreenState();
}

class _AddressScreenState extends State<AddressScreen> {
  late AddressBloc bloc;
  int selectedAddress = -1;

  @override
  void initState() {
    super.initState();
    bloc = BlocProvider.of<AddressBloc>(context);
    bloc.add(AddressStarted(context: context));
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AddressBloc, AddressState>(
      builder: (context, state) {
        if (state is CurrentAddressSuccess) {
          return Column(
            children: [
              const PriceContainer(price: 10000),
              TransportationPriceContainer(
                  transportationPrice: state.transportationCost),
              ButtonWidget(
                buttonWidth: double.infinity,
                onPressed: () {},
                text: 'افزدون نشانی جدید',
                icon: const Icon(
                  Icons.add_location,
                  size: 20,
                ),
              ),
              const SizedBox(
                height: 10,
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
              Expanded(
                child: ListView.builder(
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
                          setState(() {
                            selectedAddress = value ?? -1;
                          });
                        },
                      ),
                    );
                  },
                ),
              ),
            ],
          );
        } else {
          return Container();
        }
      },
    );
  }
}
