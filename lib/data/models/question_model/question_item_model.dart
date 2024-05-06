class QuestionItemModel {
  final String? pattern;
  final String id;
  final String title;
  final int price;
  final String nextRelation;

  const QuestionItemModel({
    required this.pattern,
    required this.id,
    required this.title,
    required this.price,
    required this.nextRelation,
  });

  QuestionItemModel.fromJson(Map<String, dynamic> json)
      : pattern = json['pattern'],
        id = json['id'],
        title = json['title'],
        price = json['price'],
        nextRelation = json['next_relation'];
}
