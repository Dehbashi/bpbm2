class QuestionItemModel {
  // final String? pattern;
  final String id;
  final String title;
  final int price;
  final String nextRelation;

  const QuestionItemModel({
    // required this.pattern,
    required this.id,
    required this.title,
    required this.price,
    required this.nextRelation,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'price': price,
      'nextRelation': nextRelation,
    };
  }

  QuestionItemModel.fromJson(Map<String, dynamic> json)
      // : pattern = json['pattern'] ?? null,
      : id = (json['id'] is String) ? json['id'] : json['id'].toString(),
        title = json['title'] ?? '',
        price = (json['price'] is String)
            ? int.parse(json['price'])
            : json['price'],
        nextRelation = json['next_relation'] ?? '';
}
