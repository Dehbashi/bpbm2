class InvoiceItemModel {
  final int id;
  final int invoiceId;
  final String title;
  final String type;
  final int number;
  final String price;
  final int purchacePrice;
  final String? serviceType;
  final String? shopType;
  final String? productName;
  final int subsidiary;
  final String unit;
  final String text;
  final int? userId;
  final String? financialType;
  final String? createdAt;
  final String? updatedAt;
  final String? deletedAt;

  const InvoiceItemModel({
    required this.id,
    required this.invoiceId,
    required this.title,
    required this.type,
    required this.number,
    required this.price,
    required this.purchacePrice,
    required this.serviceType,
    required this.shopType,
    required this.productName,
    required this.subsidiary,
    required this.unit,
    required this.text,
    required this.userId,
    required this.financialType,
    required this.createdAt,
    required this.updatedAt,
    required this.deletedAt,
  });

  InvoiceItemModel.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        invoiceId = json['factor_id'],
        title = json['title'],
        type = json['type'],
        number = json['number'],
        price = json['price'],
        purchacePrice = json['price_purchase'],
        serviceType = json['type_service'],
        shopType = json['type_shop'],
        productName = json['product_name'],
        subsidiary = json['subsidiary'],
        unit = json['unit'],
        text = json['text'],
        userId = json['user_id'],
        financialType = json['typefinancial'],
        createdAt = json['created_at'],
        updatedAt = json['updated_at'],
        deletedAt = json['deleted_at'];
}
