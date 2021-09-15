import 'package:la_boutique_de_a_y_s_app/consts/my_icons.dart';
import 'package:la_boutique_de_a_y_s_app/provider/favs_provider.dart';
import 'package:la_boutique_de_a_y_s_app/services/global_method.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'wishlist_empty.dart';
import 'wishlist_full.dart';

class WishlistScreen extends StatelessWidget {
  static const routeName = '/WishlistScreen';
  @override
  Widget build(BuildContext context) {
    GlobalMethods globalMethods = GlobalMethods();
    final favsProvider = Provider.of<FavsProvider>(context);
    return favsProvider.getFavsItems.isEmpty
        ? Scaffold(body: WishlistEmpty())
        : Scaffold(
            appBar: AppBar(
              title: Text('Lista de favoritos (${favsProvider.getFavsItems.length})'),
              actions: [
                IconButton(
                  onPressed: () {
                    globalMethods.showDialogg(
                        'Limpiar lista de favoritos!',
                        'Tu lista de favoritos se vaciara!',
                        () => favsProvider.clearFavs(),
                        context);
                    // cartProvider.clearCart();
                  },
                  icon: Icon(MyAppIcons.trash),
                )
              ],
            ),
            body: ListView.builder(
              itemCount: favsProvider.getFavsItems.length,
              itemBuilder: (BuildContext ctx, int index) {
                return ChangeNotifierProvider.value(
                    value: favsProvider.getFavsItems.values.toList()[index],
                    child: WishlistFull(
                      productId: favsProvider.getFavsItems.keys.toList()[index],
                    ));
              },
            ),
          );
  }
}
