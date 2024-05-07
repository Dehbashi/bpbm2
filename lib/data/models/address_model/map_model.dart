class MapModel {
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
  final bool idOddEvenZone;
  final String? village;
  final String? county;
  final String? district;

  const MapModel({
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
    required this.idOddEvenZone,
    required this.village,
    required this.county,
    required this.district,
  });

  MapModel.fromJson(Map<String, dynamic> json)
      : status = json['status'],
        formattedAddress = json['formatted_address'],
        routeName = json['route_name'],
        routeType = json['route_type'],
        neighborhood = json['neighbourhood'],
        city = json['city'],
        state = json['state'],
        place = json['place'],
        municipalityZone = json['municipality_zone'],
        inTrafficZone = json['in_traffic_zone'],
        idOddEvenZone = json['in_odd_even_zone'],
        village = json['village'],
        county = json['county'],
        district = json['district'];
}
