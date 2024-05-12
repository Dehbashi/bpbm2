class ProfileModel {
  final int id;
  final int userId;
  final String gender;
  final String firstName;
  final String lastName;
  final String? img;
  final String jobTitle;
  final String? createdAt;
  final String? updatedAt;
  final String name;

  const ProfileModel({
    required this.id,
    required this.userId,
    required this.gender,
    required this.firstName,
    required this.lastName,
    required this.img,
    required this.jobTitle,
    required this.createdAt,
    required this.updatedAt,
    required this.name,
  });

  ProfileModel.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        userId = json['user_id'],
        gender = json['gender'],
        firstName = json['firstname'],
        lastName = json['lastname'],
        img = json['img'],
        jobTitle = json['jobtitle'],
        createdAt = json['created_at'],
        updatedAt = json['updated_at'],
        name = json['name'];
}
