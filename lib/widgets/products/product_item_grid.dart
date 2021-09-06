import 'package:flutter/material.dart';
import 'package:la_boutique_de_a_y_s_app/screens/product_detail_screen.dart';

class ProductItemGrid extends StatelessWidget {
  final String id;
  final String name;
  final String description;
  final double price;
  final String imageUrl;
  final bool isFavorite;

  ProductItemGrid(this.id, this.name, this.description, this.price, this.imageUrl, this.isFavorite);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: GridTile(
        child: Column(
          children: [
            GestureDetector(
              onTap: () {
                Navigator.of(context).pushNamed(
                  ProductDetailScreen.routeName,
                  arguments: this.id,
                );
              },
              child: Image.network(
                this.imageUrl,
                fit: BoxFit.cover,
              ),
            ),
          ],
        ),
        footer: GridTileBar(
          backgroundColor: Colors.black87,
          leading: IconButton(
                  icon: Icon(
                    this.isFavorite ? Icons.favorite : Icons.favorite_border,
                  ),
                  color: Theme.of(context).accentColor,
                  onPressed: () {
                    //this.toggleFavoriteStatus();
                  },
                ),
          title: Text(
            this.name,
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}
