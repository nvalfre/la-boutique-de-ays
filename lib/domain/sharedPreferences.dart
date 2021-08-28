// To parse this JSON data, do
//
//     final sharedPreferences = sharedPreferencesFromJson(jsonString);

import 'dart:convert';

SharedPreferences sharedPreferencesFromJson(String str) => SharedPreferences.fromJson(json.decode(str));

String sharedPreferencesToJson(SharedPreferences data) => json.encode(data.toJson());

class SharedPreferences {
  SharedPreferences({
    this.name,
    this.countUserItemsLoad,
    this.countUserItemTap,
    this.commonsUserCategoriesLoad,
    this.latestCategory,
    this.latestVisitedItemId,
    this.latestUserOrderId,
  });

  String name;
  String countUserItemsLoad;
  String countUserItemTap;
  String commonsUserCategoriesLoad;
  String latestCategory;
  String latestVisitedItemId;
  String latestUserOrderId;

  factory SharedPreferences.fromJson(Map<String, dynamic> json) => SharedPreferences(
    name: json["name"],
    countUserItemsLoad: json["count_user_items_load"],
    countUserItemTap: json["count_user_item_tap"],
    commonsUserCategoriesLoad: json["commons_user_categories_load"],
    latestCategory: json["latest_category"],
    latestVisitedItemId: json["latest_visited_item_id"],
    latestUserOrderId: json["latest_user_order_id"],
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "count_user_items_load": countUserItemsLoad,
    "count_user_item_tap": countUserItemTap,
    "commons_user_categories_load": commonsUserCategoriesLoad,
    "latest_category": latestCategory,
    "latest_visited_item_id": latestVisitedItemId,
    "latest_user_order_id": latestUserOrderId,
  };
}
