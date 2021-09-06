import 'package:flutter/material.dart';
import 'package:la_boutique_de_a_y_s_app/screens/product_detail_screen.dart';

class ProductItem extends StatelessWidget {
  final String id;
  final String name;
  final String description;
  final double price;
  final String imageUrl;
  final bool isFavorite;

  ProductItem(this.id, this.name, this.description, this.price, this.imageUrl, this.isFavorite);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child:Container()
    );
  }
}
