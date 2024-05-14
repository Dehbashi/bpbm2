import 'package:bpbm2/data/models/order_model/invoice_item_model.dart';
import 'package:bpbm2/data/models/order_model/invoice_version_model.dart';

class InvoiceModel {
  final int id;
  final String type;
  final String title;
  final String text;
  final String orderId;
  final String paymentTerm;
  final String? numberBank;
  final String description;
  final String effectiveTo;
  final int tax;
  final int discount;
  final int status;
  final int versionStatus;
  final int flagResult;
  final int hoferStatus;
  final int payStatus;
  final String? createdAt;
  final String? updatedAt;
  final String? deletedAt;
  final List<InvoiceItemModel> items;
  final List<InvoiceVersionModel> versions;

  const InvoiceModel({
    required this.id,
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
    required this.versionStatus,
    required this.flagResult,
    required this.hoferStatus,
    required this.payStatus,
    required this.createdAt,
    required this.updatedAt,
    required this.deletedAt,
    required this.items,
    required this.versions,
  });

  InvoiceModel.fromJson(Map<String, dynamic> json)
      : id = json['id'],
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
        versionStatus = json['version_status'],
        flagResult = json['flag_result'],
        hoferStatus = json['hoferstatus'],
        payStatus = json['pay_status'],
        createdAt = json['created_at'],
        updatedAt = json['updated_at'],
        deletedAt = json['deleted_at'],
        items = (json['items'] as List<dynamic>).map((item) {
          return InvoiceItemModel.fromJson(item);
        }).toList(),
        versions = (json['versions'] as List<dynamic>).map((item) {
          return InvoiceVersionModel.fromJson(item);
        }).toList();
}
