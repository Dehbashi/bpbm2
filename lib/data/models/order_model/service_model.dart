class ServiceModel {
  final int id;
  final String title;
  final String text;
  final String img;
  final String icons;
  final String avgPrice;
  final int status;
  final String createdAt;
  final String updatedAt;

  const ServiceModel({
    required this.id,
    required this.title,
    required this.text,
    required this.img,
    required this.icons,
    required this.avgPrice,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
  });

  ServiceModel.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        title = json['title'],
        text = json['text'],
        img = json['img'],
        icons = json['icons'],
        avgPrice = json['averageprice'],
        status = json['status'],
        createdAt = json['created_at'],
        updatedAt = json['updated_at'];
}
