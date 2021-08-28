// To parse this JSON data, do
//
//     final campaign = campaignFromJson(jsonString);

import 'dart:convert';

Campaign campaignFromJson(String str) => Campaign.fromJson(json.decode(str));

String campaignToJson(Campaign data) => json.encode(data.toJson());

class Campaign {
  Campaign({
    this.id,
    this.name,
    this.type,
    this.subType,
    this.discountPercentage,
    this.productList,
    this.userList,
  });

  String id;
  String name;
  String type;
  String subType;
  String discountPercentage;
  List<String> productList;
  List<String> userList;

  factory Campaign.fromJson(Map<String, dynamic> json) => Campaign(
    id: json["id"],
    name: json["name"],
    type: json["type"],
    subType: json["subType"],
    discountPercentage: json["discount_percentage"],
    productList: List<String>.from(json["product_list"].map((x) => x)),
    userList: List<String>.from(json["user_list"].map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "type": type,
    "subType": subType,
    "discount_percentage": discountPercentage,
    "product_list": List<dynamic>.from(productList.map((x) => x)),
    "user_list": List<dynamic>.from(userList.map((x) => x)),
  };
}
