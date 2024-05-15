import 'package:bpbm2/blocs/address_bloc/address_bloc.dart';
import 'package:bpbm2/common/widgets/flutter_map_widget.dart';
import 'package:flutter/material.dart';
import 'package:location_picker_flutter_map/location_picker_flutter_map.dart';

class AddressScreenMapWidget extends StatelessWidget {
  final NewAddressSuccess state;
  final void Function(PickedData) onPicked;
  const AddressScreenMapWidget({
    super.key,
    required this.state,
    required this.onPicked,
  });

  @override
  Widget build(BuildContext context) {
    return FlutterMapWidget(
      lat: state.lat,
      lng: state.lng,
      onPicked: onPicked,
    );
  }
}
