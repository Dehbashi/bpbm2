class RelationModel {
  final int now;

  const RelationModel({required this.now});

  Map<String, dynamic> toJson() {
    return {
      'now': now,
    };
  }

  RelationModel.fromJson(Map<String, dynamic> json) : now = json['now'];
}
