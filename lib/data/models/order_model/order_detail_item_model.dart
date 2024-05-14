class OrderDetailItemModel {
  final int id;
  final int orderId;
  final String type;
  final String title;
  final String value;
  final String price;
  final int number;
  final String? createdAt;
  final String? updatedAt;
  final String? deletedAt;

  const OrderDetailItemModel({
    required this.id,
    required this.orderId,
    required this.type,
    required this.title,
    required this.value,
    required this.price,
    required this.number,
    required this.createdAt,
    required this.updatedAt,
    required this.deletedAt,
  });

  OrderDetailItemModel.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        orderId = json['order_id'],
        type = json['type'],
        title = json['title'],
        value = json['value'],
        price = json['price'],
        number = json['number'],
        createdAt = json['created_at'],
        updatedAt = json['updated_at'],
        deletedAt = json['deleted_at'];
}
