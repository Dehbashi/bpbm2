import 'package:bpbm2/blocs/address_bloc/address_bloc.dart';
import 'package:bpbm2/common/widgets/button_widget.dart';
import 'package:bpbm2/screens/stepper_screen/widgets/transportation_price_container.dart';
import 'package:bpbm2/screens/user_address_screen/user_new_address_screen.dart';
import 'package:bpbm2/screens/user_address_screen/widgets/user_current_address_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UserAddressScreen extends StatelessWidget {
  const UserAddressScreen({super.key});

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<AddressBloc>(context).add(AddressStarted(context: context));

    return BlocBuilder<AddressBloc, AddressState>(
      builder: (context, state) {
        if (state is CurrentAddressSuccess) {
          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                children: [
                  ButtonWidget(
                    buttonWidth: double.infinity,
                    icon: const Icon(
                      Icons.location_on,
                      color: Colors.white,
                      size: 20,
                    ),
                    onPressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => BlocProvider(
                            create: (context) => AddressBloc(context),
                            child: const UserNewAddressScreen(),
                          ),
                        ),
                      );
                    },
                    text: 'افزدون نشانی جدید',
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TransportationPriceContainer(
                    transportationPrice: state.transportationCost,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    'نشانی های ثبت شده قبلی\n'
                    'برای تغییر انگشت خود را بر روی آدرس نگه دارید',
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  ...state.addresses.map((address) {
                    return UserCurrentAddressList(
                      address: address,
                      addresses: state.addresses,
                    );
                  }),
                ],
              ),
            ),
          );
        } else {
          return Container();
        }
      },
    );
  }
}
