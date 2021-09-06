import 'package:flutter/material.dart';
import 'package:la_boutique_de_a_y_s_app/providers/product_provider.dart';
import 'package:la_boutique_de_a_y_s_app/widgets/products/home_body.dart';
import 'package:provider/provider.dart';

import 'app_drawer.dart';

enum FilterOptions {
  Favorites,
  All,
}

class ProductsOverviewScreen extends StatefulWidget {
  @override
  _ProductsOverviewScreenState createState() => _ProductsOverviewScreenState();
}

class _ProductsOverviewScreenState extends State<ProductsOverviewScreen> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Scaffold(
        appBar: AppBar(
          title: Center(child: Text('La boutique de AyS')),
          actions: _popUpMenu(),
        ),
        drawer: AppDrawer(),
        //body: _isLoading
        //    ? Center(child: CircularProgressIndicator())
        //    :         HomeBody(_showOnlyFavorites),
        body: HomeBody(),

        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: new FloatingActionButton(
          onPressed: () {  },
          child: const Icon(Icons.add),
        ),
      ),
    );
  }

  List<Widget> _popUpMenu() {
    return <Widget>[
      PopupMenuButton(
        onSelected: (FilterOptions selectedValue) {
          setState(() {
            if (selectedValue == FilterOptions.Favorites) {
            } else {
            }
          });
        },
        icon: Icon(
          Icons.more_vert,
        ),
        itemBuilder: (_) => [
          PopupMenuItem(
            child: Text('Favoritos'),
            value: FilterOptions.Favorites,
          ),
          PopupMenuItem(
            child: Text('Todos'),
            value: FilterOptions.All,
          ),
        ],
      ),
      // Consumer<Cart>(
      //   builder: (_, cart, ch) => Badge(
      //         child: ch,
      //         value: cart.itemCount.toString(),
      //       ),
      //   child: IconButton(
      //     icon: Icon(
      //       Icons.shopping_cart,
      //     ),
      //     onPressed: () {
      //       // Navigator.of(context).pushNamed(CartScreen.routeName);
      //     },
      //   ),
      // ),
    ];
  }
}
