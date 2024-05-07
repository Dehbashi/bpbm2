import 'package:bpbm2/data/models/question_model/question_item_model.dart';

class QuestionModel {
  final int id;
  final String title;
  final String type;
  final String list;
  final List<QuestionItemModel> items;

  const QuestionModel({
    required this.id,
    required this.title,
    required this.type,
    required this.list,
    required this.items,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'type': type,
      'list': list,
      'items': items.map((item) => item.toJson()).toList(),
    };
  }

  QuestionModel.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        title = json['title'],
        type = json['type'],
        list = json['list'],
        items = (json['items'] as List<dynamic>).map((item) {
          return QuestionItemModel.fromJson(item);
        }).toList();
}
