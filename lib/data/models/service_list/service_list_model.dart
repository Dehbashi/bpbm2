class ServiceListModel {
  final int id;
  final String title;
  final String icon;
  final int status;

  const ServiceListModel({
    required this.id,
    required this.title,
    required this.icon,
    required this.status,
  });

  ServiceListModel.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        title = json['title'],
        icon = json['icon'],
        status = json['status'];
}
