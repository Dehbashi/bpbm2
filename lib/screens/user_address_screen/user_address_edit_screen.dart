import 'package:bpbm2/data/models/address_model/address_model.dart';
import 'package:flutter/material.dart';

class UserAddressEditScreen extends StatelessWidget {
  final AddressModel address;
  const UserAddressEditScreen({super.key, required this.address});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text('User Address Edit Screen'),
    );
  }
}
