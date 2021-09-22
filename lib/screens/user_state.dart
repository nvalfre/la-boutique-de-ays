import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:la_boutique_de_a_y_s_app/models/user.dart';
import 'package:la_boutique_de_a_y_s_app/provider/user_preferences.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'landing_page.dart';
import 'main_screen.dart';

class UserState extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final FirebaseAuth _auth = FirebaseAuth.instance;
    final users = FirebaseFirestore.instance.collection('users');

    var _uid = _auth.currentUser.uid;

    return StreamBuilder(
        stream: _auth.authStateChanges(),
        // ignore: missing_return
        builder: (context, authSnapshot) {
          if (authSnapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child:  CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Theme.of(context).primaryColor),
              ),
            );
          } else if (authSnapshot.connectionState == ConnectionState.active) {
            return FutureBuilder(
                future: users.doc(_uid).get(),
                builder: (BuildContext context, AsyncSnapshot<DocumentSnapshot> userDocumentSnapshot) {
                  UserPreferences sharedPreferences = UserPreferences();
                  if (userDocumentSnapshot.hasData) {
                    loadPreferences(userDocumentSnapshot.data, sharedPreferences);
                    if (authSnapshot.hasData) {
                      print('The user is already logged in');
                      return MainScreens();
                    } else {
                      print('The user didn\'t login yet');
                      return LandingPage();
                    }
                  } else {
                    return CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(Theme.of(context).primaryColor),
                    );
                  }
                }
            );
          } else if (authSnapshot.hasError) {
            return Center(
              child: Text('Error occured'),
            );
          }
        });
  }

  void loadPreferences(
      DocumentSnapshot documentSnapshot, UserPreferences sharedPreferences) {
    if (documentSnapshot != null) {
      UserModel userModel = UserModel.fromDocumentSnapshot(documentSnapshot);
      sharedPreferences.user = userModel.id;
      sharedPreferences.userRole = userModel.userRole;
      sharedPreferences.imageUrl = userModel.imageUrl;
    }
  }
}
