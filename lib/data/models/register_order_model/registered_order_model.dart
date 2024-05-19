class RegisteredOrderModel {
  final int addressId;
  final String? createdAt;
  final String date;
  final int discount;
  final int id;
  final int productPrice;
  final int servicePrice;
  final int serviceId;
  final int tax;
  final String text;
  final String time;
  final int totalPrice;
  final int transportationCost;
  final String? updatedAt;
  final int userId;

  const RegisteredOrderModel({
    required this.addressId,
    required this.createdAt,
    required this.date,
    required this.discount,
    required this.id,
    required this.productPrice,
    required this.servicePrice,
    required this.serviceId,
    required this.tax,
    required this.text,
    required this.time,
    required this.totalPrice,
    required this.transportationCost,
    required this.updatedAt,
    required this.userId,
  });

  RegisteredOrderModel.fromJson(Map<String, dynamic> json)
      : addressId = json['address_id'],
        createdAt = json['created_at'],
        date = json['date'],
        discount = json['discount'],
        id = json['id'],
        productPrice = json['price_products'],
        servicePrice = json['price_services'],
        serviceId = json['service_id'],
        tax = json['tax'],
        text = json['text'],
        time = json['time'],
        totalPrice = json['totalprice'],
        transportationCost = json['transportationcost'],
        updatedAt = json['updated_at'],
        userId = json['user_id'];
}
