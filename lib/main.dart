import 'package:la_boutique_de_a_y_s_app/consts/theme_data.dart';
import 'package:la_boutique_de_a_y_s_app/inner_screens/product_details.dart';
import 'package:la_boutique_de_a_y_s_app/provider/dark_theme_provider.dart';
import 'package:la_boutique_de_a_y_s_app/provider/orders_provider.dart';
import 'package:la_boutique_de_a_y_s_app/provider/products.dart';
import 'package:la_boutique_de_a_y_s_app/provider/user_preferences.dart';
import 'package:la_boutique_de_a_y_s_app/screens/wishlist/wishlist.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'inner_screens/brands_navigation_rail.dart';
import 'inner_screens/categories_feeds.dart';
import 'screens/auth/forget_password.dart';
import 'screens/orders/order.dart';
import 'screens/search.dart';
import 'screens/upload_product_form.dart';
import 'provider/cart_provider.dart';
import 'provider/favs_provider.dart';
import 'screens/auth/login.dart';
import 'screens/auth/sign_up.dart';
import 'screens/top_app_bar.dart';
import 'screens/cart/cart.dart';
import 'screens/feeds.dart';
import 'screens/user_state.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await UserPreferences().initUserPreferences();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  DarkThemeProvider themeChangeProvider = DarkThemeProvider();

  void getCurrentAppTheme() async {
    themeChangeProvider.darkTheme =
        await themeChangeProvider.darkThemePreferences.getTheme();
  }

  @override
  void initState() {
    getCurrentAppTheme();
    super.initState();
  }

  final Future<FirebaseApp> _initialization = Firebase.initializeApp();
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: _initialization,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return MaterialApp(
              home: Scaffold(
                body: Center(
                  child: Column(
                    children: [
                      buildLogo(),
                      CircularProgressIndicator()
                    ],
                  ),
                ),
              ),
            );
          } else if (snapshot.hasError) {
            MaterialApp(
              home: Scaffold(
                body: Center(
                  child: Text('Error occured'),
                ),
              ),
            );
          }
          return MultiProvider(
            providers: [
              ChangeNotifierProvider(create: (_) {
                return themeChangeProvider;
              }),
              ChangeNotifierProvider(
                create: (_) => Products(),
              ),
              ChangeNotifierProvider(
                create: (_) => CartProvider(),
              ),
              ChangeNotifierProvider(
                create: (_) => FavsProvider(),
              ),
              ChangeNotifierProvider(
                create: (_) => OrdersProvider(),
              ),
            ],
            child: Consumer<DarkThemeProvider>(
              builder: (context, themeChangeProvider, ch) {
                return MaterialApp(
                  debugShowCheckedModeBanner: false,
                  title: 'La boutique de AyS',
                  theme: Styles.themeData(themeChangeProvider.darkTheme, context),
                  home: UserState(),
                  //initialRoute: '/',
                  routes: {
                    //   '/': (ctx) => LandingPage(),
                    BrandNavigationRailScreen.routeName: (ctx) =>
                        BrandNavigationRailScreen(),
                    CartScreen.routeName: (ctx) => CartScreen(),
                    Marketplace.routeName: (ctx) => Marketplace(),
                    WishlistScreen.routeName: (ctx) => WishlistScreen(),
                    ProductDetails.routeName: (ctx) => ProductDetails(),
                    CategoriesFeedsScreen.routeName: (ctx) =>
                        CategoriesFeedsScreen(),
                    LoginScreen.routeName: (ctx) => LoginScreen(),
                    SignUpScreen.routeName: (ctx) => SignUpScreen(),
                    TopBarScreen.routeName: (ctx) => TopBarScreen(),
                    UploadProductForm.routeName: (ctx) => UploadProductForm(),
                    ForgetPassword.routeName: (ctx) => ForgetPassword(),
                    OrderScreen.routeName: (ctx) => OrderScreen(),
                    Search.routeName: (ctx) => Search(),
                  },
                );
              },
            ),
          );
        });
  }

  static FadeInImage buildLogo() {
    return FadeInImage(
                      image: AssetImage('assets/logo/la-boutique-logo.gif'),
                      placeholder: AssetImage('assets/logo/la-boutique-logo.gif'),
                      fit: BoxFit.cover,
                    );
  }
}
