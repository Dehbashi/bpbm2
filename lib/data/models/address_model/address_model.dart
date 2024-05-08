class AddressModel {
  final int id;
  final String title;
  final String text;
  final String lat;
  final String lng;
  final String city;
  final String district;
  final int municipalityZone;
  final String? houseNumber;
  final String? unit;
  final int status;

  AddressModel({
    required this.id,
    required this.title,
    required this.text,
    required this.lat,
    required this.lng,
    required this.city,
    required this.district,
    required this.municipalityZone,
    required this.houseNumber,
    required this.unit,
    required this.status,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'text': text,
      'lat': lat,
      'lng': lng,
      'city': city,
      'district': district,
      'municipalityZone': municipalityZone,
      'houseNumber': houseNumber,
      'unit': unit,
      'status': status,
    };
  }

  AddressModel.fromJson(Map<String, dynamic> json)
      : id = json['id'] ?? 0,
        title = json['title'] ?? '',
        text = json['text'] ?? '',
        lat = json['latitude'] ?? '',
        lng = json['longitude'] ?? '',
        city = json['city'] ?? '',
        district = json['district'] ?? '',
        municipalityZone = json['municipality_zone'] ?? 0,
        houseNumber = json['housenumber'] ?? '',
        unit = json['unit'] ?? '',
        status = json['status'] ?? 0;
}
