class RegisterAddressModel {
  final String? city;
  final String? county;
  final String? district;
  final String? formattedAddress;
  final String? houseNumber;
  final bool inOddEvenZone;
  final bool inTrafficZone;
  final String lat;
  final String lng;
  final String? municipalityZone;
  final String? neighbourhood;
  final String? place;
  final String? routeName;
  final String? routeType;
  final String? state;
  final String status;
  final int transportationCost;
  final String type;
  final String? unit;
  final String? village;

  const RegisterAddressModel({
    required this.city,
    required this.county,
    required this.district,
    required this.formattedAddress,
    required this.houseNumber,
    required this.inOddEvenZone,
    required this.inTrafficZone,
    required this.lat,
    required this.lng,
    required this.municipalityZone,
    required this.neighbourhood,
    required this.place,
    required this.routeName,
    required this.routeType,
    required this.state,
    required this.status,
    required this.transportationCost,
    required this.type,
    required this.unit,
    required this.village,
  });

  Map<String, dynamic> toJson() {
    return {
      'city': city ?? '',
      'county': county ?? '',
      'district': district ?? '',
      'formatted_address': formattedAddress ?? '',
      'housenumber': houseNumber ?? '',
      'in_odd_even_zone': inOddEvenZone,
      'in_traffic_zone': inTrafficZone,
      'lat': lat,
      'lng': lng,
      'municipality_zone': municipalityZone,
      'neighbourhood': neighbourhood ?? '',
      'place': place ?? '',
      'route_name': routeName ?? '',
      'route_type': routeType ?? '',
      'state': state ?? '',
      'status': status,
      'transportationcost': transportationCost,
      'type': type,
      'unit': unit ?? '',
      'village': village ?? '',
    };
  }
}
