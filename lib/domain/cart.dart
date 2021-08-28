import 'dart:convert';

Cart cartFromJson(String str) => Cart.fromJson(json.decode(str));

String cartToJson(Cart data) => json.encode(data.toJson());

class Cart {
  Cart({
    this.id,
    this.dateCreated,
    this.user,
    this.productConfig,
    this.paymentConfig,
  });

  String id;
  String dateCreated;
  String user;
  List<TConfig> productConfig;
  List<TConfig> paymentConfig;

  factory Cart.fromJson(Map<String, dynamic> json) => Cart(
    id: json["id"],
    dateCreated: json["date_created"],
    user: json["user"],
    productConfig: List<TConfig>.from(json["product_config"].map((x) => TConfig.fromJson(x))),
    paymentConfig: List<TConfig>.from(json["payment_config"].map((x) => TConfig.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "date_created": dateCreated,
    "user": user,
    "product_config": List<dynamic>.from(productConfig.map((x) => x.toJson())),
    "payment_config": List<dynamic>.from(paymentConfig.map((x) => x.toJson())),
  };
}

class TConfig {
  TConfig();

  factory TConfig.fromJson(Map<String, dynamic> json) => TConfig(
  );

  Map<String, dynamic> toJson() => {
  };
}
