class ContactFormModel {
  final String formId;
  final String text;
  final String? updatedAt;
  final String? createdAt;
  final int id;

  const ContactFormModel({
    required this.formId,
    required this.text,
    required this.updatedAt,
    required this.createdAt,
    required this.id,
  });

  ContactFormModel.fromJson(Map<String, dynamic> json)
      : formId = json['form_id'],
        text = json['text'],
        updatedAt = json['updated_at'],
        createdAt = json['created_at'],
        id = json['id'];
}
