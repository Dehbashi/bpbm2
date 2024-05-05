class UserModel {
  final int id;
  final String cellNumber;

  const UserModel({
    required this.id,
    required this.cellNumber,
  });

  UserModel.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        cellNumber = json['phone'];
}
