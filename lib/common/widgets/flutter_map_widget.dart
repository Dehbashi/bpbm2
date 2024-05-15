import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:location_picker_flutter_map/location_picker_flutter_map.dart';
import 'package:latlong2/latlong.dart' as lat_lng;

class FlutterMapWidget extends StatelessWidget {
  final double lat;
  final double lng;
  final void Function(PickedData) onPicked;
  const FlutterMapWidget({
    super.key,
    required this.lat,
    required this.lng,
    required this.onPicked,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 400,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: FlutterMap(
          options: MapOptions(
            initialZoom: 15,
            initialCenter: lat_lng.LatLng(
              lat,
              lng,
            ),
          ),
          children: [
            TileLayer(
              urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
              userAgentPackageName: 'dev.fleaflet.flutter_map.example',
            ),
            FlutterLocationPicker(
              searchbarInputBorder: const OutlineInputBorder(
                borderSide: BorderSide.none,
              ),
              searchbarInputFocusBorderp: const OutlineInputBorder(
                borderSide: BorderSide.none,
              ),
              mapLanguage: 'fa',
              searchBarHintText: 'جستجو ...',
              selectLocationButtonText: 'انتخاب آدرس',
              selectedLocationButtonTextstyle:
                  Theme.of(context).textTheme.bodyMedium!,
              selectLocationButtonWidth: 150,
              selectLocationButtonPositionRight:
                  MediaQuery.of(context).size.width * 0.5,
              searchBarTextColor: Theme.of(context).colorScheme.onBackground,
              initPosition: LatLong(lat, lng),
              onPicked: onPicked,
            ),
          ],
        ),
      ),
    );
  }
}
