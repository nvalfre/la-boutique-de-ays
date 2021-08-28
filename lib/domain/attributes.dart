import 'dart:convert';

Attributes attributtesFromJson(String str) => Attributes.fromJson(json.decode(str));

String attributtesToJson(Attributes data) => json.encode(data.toJson());

class Attributes {
  Attributes({
    this.size,
    this.supplier,
    this.brand,
    this.year,
  });

  String size;
  String supplier;
  String brand;
  int year;

  factory Attributes.fromJson(Map<String, dynamic> json) => Attributes(
    size: json["size"],
    supplier: json["supplier"],
    brand: json["brand"],
    year: json["year"],
  );

  Map<String, dynamic> toJson() => {
    "size": size,
    "supplier": supplier,
    "brand": brand,
    "year": year,
  };
}
