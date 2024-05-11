class TimeModel {
  final int id;
  final String title;
  final String text;

  const TimeModel({
    required this.id,
    required this.title,
    required this.text,
  });

  TimeModel.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        title = json['title'],
        text = json['text'];
}
