class RelationModel {
  final int now;

  const RelationModel({required this.now});

  RelationModel.fromJson(Map<String, dynamic> json) : now = json['now'];
}
