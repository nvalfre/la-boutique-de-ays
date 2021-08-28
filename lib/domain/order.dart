import 'dart:convert';

import 'package:la_boutique_de_a_y_s_app/domain/product.dart';

Cart cartFromJson(String str) => Cart.fromJson(json.decode(str));

String cartToJson(Cart data) => json.encode(data.toJson());

class Cart {
  Cart({
    this.id,
    this.orderDate,
    this.price,
    this.quantity,
    this.metadata,
  });

  String id;
  String orderDate;
  int price;
  int quantity;
  Metadata metadata;

  factory Cart.fromJson(Map<String, dynamic> json) => Cart(
    id: json["id"],
    orderDate: json["order_date"],
    price: json["price"],
    quantity: json["quantity"],
    metadata: Metadata.fromJson(json["metadata"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "order_date": orderDate,
    "price": price,
    "quantity": quantity,
    "metadata": metadata.toJson(),
  };
}

class Metadata {
  Metadata({
    this.product,
  });

  Product product;

  factory Metadata.fromJson(Map<String, dynamic> json) => Metadata(
    product: Product.fromJson(json["product"]),
  );

  Map<String, dynamic> toJson() => {
    "product": product.toJson(),
  };
}
