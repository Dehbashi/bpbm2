class ServiceFaqModel {
  final int id;
  final int serviceId;
  final String title;
  final String text;
  final int status;
  final String? createdAt;
  final String? updatedAt;
  final String? deletedAt;

  const ServiceFaqModel({
    required this.id,
    required this.serviceId,
    required this.title,
    required this.text,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
    required this.deletedAt,
  });

  ServiceFaqModel.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        serviceId = json['service_id'],
        title = json['title'],
        text = json['text'],
        status = json['status'],
        createdAt = json['created_at'],
        updatedAt = json['updated_at'],
        deletedAt = json['deleted_at'];
}
