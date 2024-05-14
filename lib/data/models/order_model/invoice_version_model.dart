import 'package:bpbm2/data/models/order_model/invoice_item_model.dart';

class InvoiceVersionModel {
  final int id;
  final int version;
  final int invoiceId;
  final String type;
  final String title;
  final String? text;
  final int? orderId;
  final String? paymentTerm;
  final String? numberBank;
  final String? description;
  final String? effectiveTo;
  final int tax;
  final int discount;
  final int? status;
  final String? createdAt;
  final String? updatedAt;
  final String? deletedAt;
  final List<InvoiceItemModel> items;

  const InvoiceVersionModel({
    required this.id,
    required this.version,
    required this.invoiceId,
    required this.type,
    required this.title,
    required this.text,
    required this.orderId,
    required this.paymentTerm,
    required this.numberBank,
    required this.description,
    required this.effectiveTo,
    required this.tax,
    required this.discount,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
    required this.deletedAt,
    required this.items,
  });

  InvoiceVersionModel.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        version = json['version'],
        invoiceId = json['factor_id'],
        type = json['type'],
        title = json['title'],
        text = json['text'],
        orderId = json['order_id'],
        paymentTerm = json['payment_term'],
        numberBank = json['numberbank'],
        description = json['description'],
        effectiveTo = json['effectiveto'],
        tax = json['tax'],
        discount = json['discount'],
        status = json['status'],
        createdAt = json['created_at'],
        updatedAt = json['updated_at'],
        deletedAt = json['deletedAt'],
        items = (json['items'] as List<dynamic>).map((item) {
          return InvoiceItemModel.fromJson(item);
        }).toList();
}
