class RegisterServiceModel {
  // final String icon;
  final int id;
  // final String img;
  final int status;
  final String title;
  final String url;

  const RegisterServiceModel({
    // required this.icon,
    required this.id,
    // required this.img,
    required this.status,
    required this.title,
    required this.url,
  });

  Map<String, dynamic> toJson() {
    return {
      'icon': '/assets/images/services/icon$id.png',
      'id': id,
      'img': '/assets/images/services/pic$id.png',
      'status': status,
      'title': title,
      'url': url,
    };
  }
}
