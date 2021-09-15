import 'package:la_boutique_de_a_y_s_app/consts/colors.dart';
import 'package:la_boutique_de_a_y_s_app/consts/my_icons.dart';
import 'package:la_boutique_de_a_y_s_app/models/product.dart';
import 'package:la_boutique_de_a_y_s_app/provider/cart_provider.dart';
import 'package:la_boutique_de_a_y_s_app/provider/favs_provider.dart';
import 'package:la_boutique_de_a_y_s_app/provider/products.dart';
import 'package:la_boutique_de_a_y_s_app/screens/wishlist/wishlist.dart';
import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:la_boutique_de_a_y_s_app/widget/feeds_products.dart';
import 'package:provider/provider.dart';

import 'cart/cart.dart';

class Marketplace extends StatefulWidget {
  static const routeName = '/Marketplace';

  @override
  _MarketplaceState createState() => _MarketplaceState();
}

class _MarketplaceState extends State<Marketplace> {
  Future<void> _getProductsOnRefresh() async {
    await Provider.of<Products>(context, listen: false).fetchProducts();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final popular = ModalRoute.of(context).settings.arguments as String;
    final productsProvider = Provider.of<Products>(
      context,
    );

    List<Product> productsList = productsProvider.products;
    if (popular == 'popular') {
      productsList = productsProvider.popularProducts;
    }
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).cardColor,
        title: Text('Nuestros productos'),
        actions: [
          Consumer<FavsProvider>(
            builder: (_, favs, ch) => Badge(
              badgeColor: ColorsConsts.cartBadgeColor,
              animationType: BadgeAnimationType.slide,
              toAnimate: true,
              position: BadgePosition.topEnd(top: 5, end: 7),
              badgeContent: Text(
                favs.getFavsItems.length.toString(),
                style: TextStyle(color: Colors.white),
              ),
              child: IconButton(
                icon: Icon(
                  MyAppIcons.wishlist,
                  color: ColorsConsts.favColor,
                ),
                onPressed: () {
                  Navigator.of(context).pushNamed(WishlistScreen.routeName);
                },
              ),
            ),
          ),
          Consumer<CartProvider>(
            builder: (_, cart, ch) => Badge(
              badgeColor: ColorsConsts.cartBadgeColor,
              animationType: BadgeAnimationType.slide,
              toAnimate: true,
              position: BadgePosition.topEnd(top: 5, end: 7),
              badgeContent: Text(
                cart.getCartItems.length.toString(),
                style: TextStyle(color: Colors.white),
              ),
              child: IconButton(
                icon: Icon(
                  MyAppIcons.cart,
                  color: ColorsConsts.cartColor,
                ),
                onPressed: () {
                  Navigator.of(context).pushNamed(CartScreen.routeName);
                },
              ),
            ),
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: _getProductsOnRefresh,
        child: GridView.count(
          crossAxisCount: 2,
          childAspectRatio: 240 / 420,
          crossAxisSpacing: 8,
          mainAxisSpacing: 8,
          children: List.generate(productsList.length, (index) {
            return ChangeNotifierProvider.value(
              value: productsList[index],
              child: FeedProducts(),
            );
          }),
        ),
      ),

//         StaggeredGridView.countBuilder(
//           padding: ,
//   crossAxisCount: 6,
//   itemCount: 8,
//   itemBuilder: (BuildContext context, int index) =>FeedProducts(),
//   staggeredTileBuilder: (int index) =>
//       new StaggeredTile.count(3, index.isEven ? 4 : 5),
//   mainAxisSpacing: 8.0,
//   crossAxisSpacing: 6.0,
// ),
    );
  }
}