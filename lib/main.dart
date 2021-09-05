import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'package:la_boutique_de_a_y_s_app/router/router.dart';

import 'router/router_constants.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _initialization,
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return SomethingWentWrong();
        }

        if (snapshot.connectionState == ConnectionState.done) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'La boutique de AyS',
            theme: themeData(context),
            onGenerateRoute: RouterMapping.generateRoute,
            initialRoute: homeRoute,
          );
        }

        return CircularProgressIndicator();
      },
    );
  }

  ThemeData themeData(BuildContext ctx) {
    return ThemeData(
      primarySwatch: getMaterialColor(),
      backgroundColor: Colors.deepPurpleAccent,
      accentColor: Colors.pink,
      accentColorBrightness: Brightness.dark,
      buttonTheme: ButtonTheme.of(ctx).copyWith(
        buttonColor: Colors.pink,
        textTheme: ButtonTextTheme.primary,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
      ),
    );
  }

  MaterialColor getMaterialColor() {
    var r = 255;
    var g = 192;
    var b = 203;
    Map<int, Color> color = {
      50: Color.fromRGBO(r, g, b, .1),
      100: Color.fromRGBO(r, g, b, .2),
      200: Color.fromRGBO(r, g, b, .3),
      300: Color.fromRGBO(r, g, b, .4),
      400: Color.fromRGBO(r, g, b, .5),
      500: Color.fromRGBO(r, g, b, .6),
      600: Color.fromRGBO(r, g, b, .7),
      700: Color.fromRGBO(r, g, b, .8),
      800: Color.fromRGBO(r, g, b, .9),
      900: Color.fromRGBO(r, g, b, 1),
    };

    // MaterialColor colorCustom = MaterialColor(0xFFF62EFD, color);
    MaterialColor colorCustom = MaterialColor(0xFFE22CE8, color);
    return colorCustom;
  }

  Widget SomethingWentWrong() {
    return Container(
      child: Text("error"),
    );
  }
}
