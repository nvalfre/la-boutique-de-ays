// To parse this JSON data, do
//
//     final product = productFromJson(jsonString);

import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

import 'attributes.dart';
// Rueda, Bozu, Matt x3 4, 6, 10, Rollo, Rodillo, Zafu

Favorites favoritesFromJson(String str) => Favorites.fromJson(json.decode(str));

String favoritesToJson(Favorites data) => json.encode(data.toJson());

class Favorites {
  Favorites({
    this.id,
    this.listProducts,
  });

  String id;
  List<String> listProducts;

  factory Favorites.fromJson(Map<String, dynamic> json) => Favorites(
        id: json["id"],
        listProducts: json["list_products"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "listProducts": listProducts,
      };

  factory Favorites.fromSnapshot(DocumentSnapshot snap) => Favorites(
        id: snap.id,
    listProducts: snap.data()["listProducts"],
      );

  factory Favorites.fromQuerySnapshot(QuerySnapshot snap) {
    var document = snap.docs[0];
    return Favorites(
        id: document.data()['id'],
        listProducts: document.data()["listProducts"]);
  }
}
