import 'package:bpbm2/blocs/address_bloc/address_bloc.dart';
import 'package:bpbm2/data/models/address_model/address_model.dart';
import 'package:bpbm2/screens/user_address_screen/user_address_edit_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:persian/persian.dart';

class UserCurrentAddressList extends StatelessWidget {
  final AddressModel address;
  final List<AddressModel> addresses;
  const UserCurrentAddressList({
    super.key,
    required this.address,
    required this.addresses,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      splashColor: Theme.of(context).colorScheme.onPrimary,
      borderRadius: BorderRadius.circular(10),
      onTap: () {
        BlocProvider.of<AddressBloc>(context).add(
          CurrentAddressSelected(
            context: context,
            address: address,
            addresses: addresses,
          ),
        );
      },
      onLongPress: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => BlocProvider(
              create: (context) => AddressBloc(context),
              child: UserAddressEditScreen(
                address: address,
              ),
            ),
          ),
        );
      },
      child: Container(
        width: double.infinity,
        margin: const EdgeInsets.fromLTRB(10, 5, 10, 5),
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.primary,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Text(
          '${address.text} پلاک ${address.houseNumber.toString().withPersianNumbers()} واحد ${address.unit.toString().withPersianNumbers()}',
        ),
      ),
    );
  }
}
