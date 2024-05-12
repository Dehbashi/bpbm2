class UserAddressModel {
  final int id;
  final int userId;
  final String title;
  final int cityId;
  final String lat;
  final String lng;
  final String text;
  final String? details;
  final int? municipalityZone;
  final String? cellNumber;
  final String? district;
  final String? unitNumber;
  final String? houseNumber;
  final int status;
  final String? createdAt;
  final String? updatedAt;

  const UserAddressModel({
    required this.id,
    required this.userId,
    required this.title,
    required this.cityId,
    required this.lat,
    required this.lng,
    required this.text,
    required this.details,
    required this.municipalityZone,
    required this.cellNumber,
    required this.district,
    required this.unitNumber,
    required this.houseNumber,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
  });

  UserAddressModel.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        userId = json['user_id'],
        title = json['title'],
        cityId = json['city_id'],
        lat = json['latitude'],
        lng = json['longitude'],
        text = json['text'],
        details = json['details'],
        municipalityZone = json['municipality_zone'],
        cellNumber = json['phone_number'],
        district = json['district'],
        unitNumber = json['unit'],
        houseNumber = json['housenumber'],
        status = json['status'],
        createdAt = json['created_at'],
        updatedAt = json['updated_at'];
}
