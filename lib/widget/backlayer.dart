import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:la_boutique_de_a_y_s_app/consts/colors.dart';
import 'package:la_boutique_de_a_y_s_app/consts/my_icons.dart';
import 'package:la_boutique_de_a_y_s_app/models/enum/user_role.dart';
import 'package:la_boutique_de_a_y_s_app/models/user.dart';
import 'package:la_boutique_de_a_y_s_app/provider/user_preferences.dart';
import 'package:la_boutique_de_a_y_s_app/screens/upload_product_form.dart';
import 'package:la_boutique_de_a_y_s_app/screens/cart/cart.dart';
import 'package:la_boutique_de_a_y_s_app/screens/feeds.dart';
import 'package:flutter/material.dart';

class BackLayerMenu extends StatefulWidget {
  @override
  _BackLayerMenuState createState() => _BackLayerMenuState();
}

class _BackLayerMenuState extends State<BackLayerMenu> {
  @override
  Widget build(BuildContext context) {
    final UserPreferences userPreferences = UserPreferences();
    return Stack(
      fit: StackFit.expand,
      children: [
        Ink(
          decoration: BoxDecoration(
            gradient: LinearGradient(
                colors: [
                  ColorsConsts.starterColor,
                  ColorsConsts.endColor,
                ],
                begin: const FractionalOffset(0.0, 0.0),
                end: const FractionalOffset(1.0, 0.0),
                stops: [0.0, 1.0],
                tileMode: TileMode.clamp),
          ),
        ),
        Positioned(
          top: -100.0,
          left: 140.0,
          child: Transform.rotate(
            angle: -0.5,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15.0),
                color: Colors.white54.withOpacity(0.3),
              ),
              width: 100,
              height: 200,
            ),
          ),
        ),
        Positioned(
          top: -50.0,
          left: 60.0,
          child: Transform.rotate(
            angle: -0.5,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20.0),
                color: Colors.pink.withOpacity(0.3),
              ),
              width: 150,
              height: 100,
            ),
          ),
        ),
        Positioned(
          top: 200.0,
          left: 400.0,
          child: Transform.rotate(
            angle: -0.5,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15.0),
                color: Colors.white54.withOpacity(0.3),
              ),
              width: 100,
              height: 200,
            ),
          ),
        ),
        Positioned(
          top: 200.0,
          left: 250.0,
          child: Transform.rotate(
            angle: -0.5,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20.0),
                color: Colors.pink.withOpacity(0.3),
              ),
              width: 150,
              height: 100,
            ),
          ),
        ),
        SingleChildScrollView(
          child: Container(
            margin: EdgeInsets.all(24),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Center(
                  child: Container(
                    padding: const EdgeInsets.all(8.0),
                    height: 80,
                    width: 80,
                    decoration: BoxDecoration(
                        color: Theme
                            .of(context)
                            .backgroundColor,
                        borderRadius: BorderRadius.circular(50.0)),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50.0),
                        image: DecorationImage(
                            image: NetworkImage(userPreferences.imageUrl),
                            fit: BoxFit.fill),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 5.0),
                content(context, () {
                  navigateTo(context, Marketplace.routeName);
                }, 'Marketplace', 0),
                const SizedBox(height: 5.0),
                content(context, () {
                  navigateTo(context, CartScreen.routeName);
                }, 'Carrito', 1),
                const SizedBox(height: 5.0),
                content(context, () {
                  navigateTo(context, Marketplace.routeName);
                }, 'Favoritos', 2),
                const SizedBox(height: 5.0),
                uploadProductAdmin(userPreferences, context),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget uploadProductAdmin(final UserPreferences userPreferences,
      BuildContext context) {
    UserPreferences sharedPreferences = UserPreferences();
    final FirebaseAuth _auth = FirebaseAuth.instance;
    final sizedBox = const SizedBox(height: 5.0);
    if(_auth.currentUser.isAnonymous) {
      sharedPreferences.userRole = UserRole.GUEST.toString();
      return sizedBox;
    }
    if(sharedPreferences.isLoadedAdmin()) {
      return uploadProductContent();
    }
    //actually is the unique and the one of the first componentes,
    // evaluate move this function into first render components.
    return FutureBuilder(
        future: FirebaseFirestore.instance.collection('users').doc(_auth.currentUser.uid).get(),
        builder: (context, snapshot) {
          if(snapshot.hasData){
            UserModel userModel = UserModel.fromDocumentSnapshot(snapshot.data);
            sharedPreferences.loadUser(userModel);

            if(sharedPreferences.isLoadedAdmin()) {
              return uploadProductContent();
            } else {
              return sizedBox;
            }
          } else {
            return sizedBox;
          }
        });
  }

  Widget uploadProductContent(){
    return content(context, () {
      navigateTo(context, UploadProductForm.routeName);
    }, 'Subir nuevo producto', 3);
  }

  List _contentIcons = [
    MyAppIcons.rss,
    MyAppIcons.bag,
    MyAppIcons.wishlist,
    MyAppIcons.upload
  ];

  void navigateTo(BuildContext ctx, String routeName) {
    Navigator.of(ctx).pushNamed(
      routeName,
    );
  }

  Widget content(BuildContext ctx, Function fct, String text, int index) {
    return InkWell(
      onTap: fct,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Text(
              text,
              style: TextStyle(fontWeight: FontWeight.w700),
              textAlign: TextAlign.center,
            ),
          ),
          Icon(_contentIcons[index])
        ],
      ),
    );
  }
}
