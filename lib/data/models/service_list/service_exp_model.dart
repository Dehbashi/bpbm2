class ServiceExpModel {
  final int id;
  final String title;
  final String text;
  final String avgPrice;
  final String img;
  final String date;

  const ServiceExpModel({
    required this.id,
    required this.title,
    required this.text,
    required this.avgPrice,
    required this.img,
    required this.date,
  });

  ServiceExpModel.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        title = json['title'],
        text = json['text'],
        avgPrice = json['averageprice'],
        img = json['img'],
        date = json['date'];
}
