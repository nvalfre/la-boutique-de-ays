import 'dart:convert';

import 'package:la_boutique_de_a_y_s_app/domain/product.dart';

Payment paymentFromJson(String str) => Payment.fromJson(json.decode(str));

String paymentToJson(Payment data) => json.encode(data.toJson());

class Payment {
  Payment({
    this.id,
    this.orderId,
    this.paymentDate,
    this.amount,
    this.product,
    this.quantity,
    this.metadata,
  });

  String id;
  String orderId;
  String paymentDate;
  int amount;
  Product product;
  int quantity;
  Metadata metadata;

  factory Payment.fromJson(Map<String, dynamic> json) => Payment(
    id: json["id"],
    orderId: json["order_id"],
    paymentDate: json["payment_date"],
    amount: json["amount"],
    product: Product.fromJson(json["product"]),
    quantity: json["quantity"],
    metadata: Metadata.fromJson(json["metadata"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "order_id": orderId,
    "payment_date": paymentDate,
    "amount": amount,
    "product": product.toJson(),
    "quantity": quantity,
    "metadata": metadata.toJson(),
  };
}

class Metadata {
  Metadata();

  factory Metadata.fromJson(Map<String, dynamic> json) => Metadata(
  );

  Map<String, dynamic> toJson() => {
  };
}
