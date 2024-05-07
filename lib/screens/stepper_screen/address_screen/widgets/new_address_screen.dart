import 'package:bpbm2/blocs/address_bloc/address_bloc.dart';
import 'package:bpbm2/common/widgets/button_widget.dart';
import 'package:bpbm2/screens/stepper_screen/address_screen/widgets/address_status.dart';
import 'package:bpbm2/screens/stepper_screen/widgets/price_container.dart';
import 'package:bpbm2/screens/stepper_screen/widgets/transportation_price_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart' as lat_lng;
import 'package:map_location_picker/map_location_picker.dart';

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
        const PriceContainer(price: 10000),
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
        SizedBox(
          height: 300,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: FlutterMap(
              options: const MapOptions(
                initialZoom: 15,
                initialCenter: lat_lng.LatLng(
                  35.7006381,
                  51.4089094,
                ),
              ),
              children: [
                TileLayer(
                  urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                  userAgentPackageName: 'dev.fleaflet.flutter_map.example',
                ),
              ],
            ),
          ),
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
