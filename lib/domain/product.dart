// To parse this JSON data, do
//
//     final product = productFromJson(jsonString);

import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

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
    this.avatar,
    this.status,
    this.attributes,
  });

  String id;
  double price;
  String name;
  String description;
  String avatar;
  String status;
  Attributes attributes;

  factory Product.fromJson(Map<String, dynamic> json) => Product(
        id: json["id"],
        price: json["price"],
        name: json["name"],
        description: json["description"],
        avatar: json["avatar"],
        status: json["status"],
        attributes: Attributes.fromJson(json["attributes"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "price": price,
        "name": name,
        "description": description,
        "avatar": avatar,
        "attributes": attributes.toJson(),
      };

  factory Product.fromSnapshot(DocumentSnapshot snap) => Product(
        id: snap.id,
        name: snap.data()["name"],
        price: snap.data()["price"],
        description: snap.data()["description"],
        avatar: snap.data()["avatar"],
        status: snap.data()["status"],
        attributes: Attributes.fromJson(snap.data()["attributes"]),
      );

  factory Product.fromQuerySnapshot(QuerySnapshot snap) {
    var document = snap.docs[0];
    return Product(
        id: document.data()['id'],
        name: document.data()["name"],
        price: document.data()["price"],
        avatar: document.data()["avatar"],
        status: document.data()["status"],
        attributes: Attributes.fromJson(document.data()["attributes"]));
  }

  String getStatus() {
    final defaultProductStatus = 'Sin establecer';
    var status = this.status == "" || this.status == null
        ? defaultProductStatus
        : this.status;
    return status;
  }}
