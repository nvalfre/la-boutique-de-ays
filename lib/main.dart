import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'router/router.dart';
import 'router/router_constants.dart';
import 'screens/auth_screen.dart';

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

        return CircularProgressIndicator();
      },
    );
  }

  Widget SomethingWentWrong() {
    return Container(
      child: Text("error"),
    );
  }
}
