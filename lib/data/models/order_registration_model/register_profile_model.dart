class RegisterProfileModel {
  final String firstName;
  final String lastName;

  const RegisterProfileModel({
    required this.firstName,
    required this.lastName,
  });

  Map<String, dynamic> toJson() {
    return {
      'firstname': firstName,
      'lastname': lastName,
    };
  }
}
