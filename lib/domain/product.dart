// To parse this JSON data, do
//
//     final product = productFromJson(jsonString);

import 'dart:convert';

import 'attributes.dart';
// Rueda, Bozu, Matt x3 4, 6, 10, Rollo, Rodillo, Zafu

Product productFromJson(String str) => Product.fromJson(json.decode(str));

String productToJson(Product data) => json.encode(data.toJson());

class Product {
  Product({
    this.id,
    this.price,
    this.name,
    this.description,
    this.attributes,
  });

  String id;
  int price;
  String name;
  String description;
  Attributes attributes;

  factory Product.fromJson(Map<String, dynamic> json) => Product(
    id: json["id"],
    price: json["price"],
    name: json["name"],
    description: json["description"],
    attributes: Attributes.fromJson(json["attributes"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "price": price,
    "name": name,
    "description": description,
    "attributes": attributes.toJson(),
  };
}