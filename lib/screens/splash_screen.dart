import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
  UserCredential authResult;

  SplashScreen(UserCredential authResult){
    this.authResult = authResult;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body:  Center(
        child: Text('Loading...'),
      ),
    );
  }
}
