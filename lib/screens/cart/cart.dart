import 'package:la_boutique_de_a_y_s_app/consts/colors.dart';
import 'package:la_boutique_de_a_y_s_app/consts/my_icons.dart';
import 'package:la_boutique_de_a_y_s_app/models/cart_attr.dart';
import 'package:la_boutique_de_a_y_s_app/models/product.dart';
import 'package:la_boutique_de_a_y_s_app/provider/cart_provider.dart';
import 'package:la_boutique_de_a_y_s_app/services/global_method.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:la_boutique_de_a_y_s_app/widget/whatsapp.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

import 'cart_empty.dart';
import 'cart_full.dart';

class CartScreen extends StatefulWidget {
  //To be known 1) the amount must be an integer 2) the amount must not be double 3) the minimum amount should be less than 0.5 $
  static const routeName = '/CartScreen';

  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  var response;
  Future<void> payWithCard({int amount}) async {
    ProgressDialog dialog = ProgressDialog(context);
    dialog.style(message: 'Porfavor espera...');
    await dialog.show();
    await dialog.hide();
    print('response : ${response.success}');
    Scaffold.of(context).showSnackBar(SnackBar(
      content: Text(response.message),
      duration: Duration(milliseconds: response.success == true ? 1200 : 3000),
    ));
  }

  GlobalMethods globalMethods = GlobalMethods();
  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<CartProvider>(context);

    return cartProvider.getCartItems.isEmpty
        ? Scaffold(body: CartEmpty())
        : Scaffold(
            bottomSheet: checkoutSection(context, cartProvider.totalAmount),
            appBar: AppBar(
              backgroundColor: Theme.of(context).backgroundColor,
              title: Text('Carrito (${cartProvider.getCartItems.length})'),
              actions: [
                IconButton(
                  onPressed: () {
                    globalMethods.showDialogg(
                        'Vaciar carrito!',
                        'Se vaciara el carrito!',
                        () => cartProvider.clearCart(),
                        context);
                    // cartProvider.clearCart(); //TODO
                  },
                  icon: Icon(MyAppIcons.trash),
                )
              ],
            ),
            body: Container(
              margin: EdgeInsets.only(bottom: 60),
              child: ListView.builder(
                  itemCount: cartProvider.getCartItems.length,
                  itemBuilder: (BuildContext ctx, int index) {
                    return ChangeNotifierProvider.value(
                      value: cartProvider.getCartItems.values.toList()[index],
                      child: CartFull(
                        productId:
                            cartProvider.getCartItems.keys.toList()[index],
                        // id:  cartProvider.getCartItems.values.toList()[index].id,
                        // productId: cartProvider.getCartItems.keys.toList()[index],
                        // price: cartProvider.getCartItems.values.toList()[index].price,
                        // title: cartProvider.getCartItems.values.toList()[index].title,
                        // imageUrl: cartProvider.getCartItems.values.toList()[index].imageUrl,
                        // quatity: cartProvider.getCartItems.values.toList()[index].quantity,
                      ),
                    );
                  }),
            ),
          );
  }

  Widget checkoutSection(BuildContext ctx, double subtotal) {
    final cartProvider = Provider.of<CartProvider>(context);
    var uuid = Uuid();
    final FirebaseAuth _auth = FirebaseAuth.instance;
    return Container(
        decoration: BoxDecoration(
          border: Border(
            top: BorderSide(color: Colors.grey, width: 0.5),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            /// mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                flex: 2,
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    gradient: LinearGradient(colors: [
                      ColorsConsts.gradiendLStart,
                      ColorsConsts.gradiendLEnd,
                    ], stops: [
                      0.0,
                      0.7
                    ]),
                  ),
                  child: Material(
                    color: Colors.transparent,
                    child: OpenWhatsapp(transformMap(cartProvider.getCartItems))
                  ),
                ),
              ),
              Spacer(),
              Text(
                'Total:',
                style: TextStyle(
                    color: Colors.black54,
                    fontSize: 18,
                    fontWeight: FontWeight.w600),
              ),
              Text(
                '\$ ${subtotal.toStringAsFixed(3)}',
                //textAlign: TextAlign.center,
                style: TextStyle(
                    color: Colors.blue,
                    fontSize: 18,
                    fontWeight: FontWeight.w500),
              ),
            ],
          ),
        ));
  }

  List<Product> transformMap(Map<String, CartAttr> getCartItems) {
    List<Product> list = [];
    getCartItems.forEach((key, value) {
      list.add(transform(value));
    });
    return list;
  }

  Product transform(CartAttr value) {
    return Product(
        id: value.productId,
        title: value.title,
        price: value.price,
        imageUrl: value.imageUrl,
        quantity: value.quantity);
  }
}
