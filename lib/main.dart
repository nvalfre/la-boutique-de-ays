import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:la_boutique_de_a_y_s_app/router.dart';
import 'package:la_boutique_de_a_y_s_app/screens/auth_screen.dart';
import 'package:la_boutique_de_a_y_s_app/router_constants.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'FlutterChat',
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
        backgroundColor: Colors.pink,
        accentColor: Colors.pink,
        accentColorBrightness: Brightness.dark,
        buttonTheme: ButtonTheme.of(context).copyWith(
          buttonColor: Colors.pink,
          textTheme: ButtonTextTheme.primary,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
        ),
      ),
      onGenerateRoute: RouterMapping.generateRoute,
      initialRoute: homeRoute,
    );
  }

  FutureBuilder<FirebaseApp> homeRoutes() {
    return FutureBuilder(
      future: _initialization,
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return SomethingWentWrong();
        }


        if (snapshot.connectionState == ConnectionState.done) {
          return AuthScreen();
        }

        return CircularProgressIndicator();
      },
    );
  }

  Widget SomethingWentWrong() {
    return Container(child: Text("error"),);
  }
}

