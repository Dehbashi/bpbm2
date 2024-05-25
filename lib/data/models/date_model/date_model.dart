class DateModel {
  final int id;
  final String text;
  final String title;

  const DateModel({
    required this.id,
    required this.text,
    required this.title,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id.toString(),
      'text': text,
      'title': title,
    };
  }

  DateModel.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        text = json['text'],
        title = json['title'];
}
