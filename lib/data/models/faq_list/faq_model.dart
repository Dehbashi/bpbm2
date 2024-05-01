class FaqModel {
  final int id;
  final int? serviceId;
  final String? type;
  final String title;
  final String text;
  final int? status;
  final String? createdAt;
  final String? updatedAt;
  final String? deletedAt;

  const FaqModel({
    required this.id,
    required this.serviceId,
    required this.type,
    required this.title,
    required this.text,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
    required this.deletedAt,
  });

  FaqModel.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        serviceId = json['service_id'],
        type = json['type'],
        title = json['title'],
        text = json['text'],
        status = json['status'],
        createdAt = json['created_at'],
        updatedAt = json['updated_at'],
        deletedAt = json['deleted_at'];
}
