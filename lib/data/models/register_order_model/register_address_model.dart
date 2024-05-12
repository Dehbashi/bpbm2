class RegisterAddressModel {
  final String status;
  final String formattedAddress;
  final String? routeName;
  final String? routeType;
  final String neighborhood;
  final String? city;
  final String? state;
  final String? place;
  final String municipalityZone;
  final bool inTrafficZone;
  final bool inOddEvenZone;
  final String? village;
  final String? county;
  final String? district;
  final String lat;
  final String lng;
  final int transprotationCost;
  final String type;

  const RegisterAddressModel({
    required this.status,
    required this.formattedAddress,
    required this.routeName,
    required this.routeType,
    required this.neighborhood,
    required this.city,
    required this.state,
    required this.place,
    required this.municipalityZone,
    required this.inTrafficZone,
    required this.inOddEvenZone,
    required this.village,
    required this.county,
    required this.district,
    required this.lat,
    required this.lng,
    required this.transprotationCost,
    required this.type,
  });

  Map<String, dynamic> toJson() {
    return {
      'city': city,
      'county': county,
      'district': district,
      'formatted_address': formattedAddress,
      'in_odd_even_zone': inOddEvenZone,
      'in_traffic_zone': inTrafficZone,
      'lat': lat,
      'lng': lng,
      'municipality_zone': municipalityZone,
      'neighbourhood': neighborhood,
      'place': place,
      'route_name': routeName,
      'route_type': routeType,
      'state': state,
      'status': status,
      'transportationcost': transprotationCost,
      'type': type,
      'village': village,
    };
  }
}
