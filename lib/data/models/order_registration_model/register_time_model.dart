class RegisterTimeModel {
  final int id;
  final String title;
  final String value;

  const RegisterTimeModel({
    required this.id,
    required this.title,
    required this.value,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'value': value,
    };
  }
}
