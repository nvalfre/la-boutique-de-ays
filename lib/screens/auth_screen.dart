import 'dart:io';

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:la_boutique_de_a_y_s_app/screens/splash_screen.dart';

import 'package:la_boutique_de_a_y_s_app/widgets/auth/auth_form.dart';

class AuthScreen extends StatefulWidget {
  @override
  _AuthScreenState createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final _auth = FirebaseAuth.instance;
  var _isLoading = false;

  void _submitAuthForm(
    String email,
    String password,
    String username,
    File image,
    bool isLogin,
    bool isGuest,
    BuildContext ctx,
  ) async {
    UserCredential authResult;

    try {
      setState(() {
        _isLoading = true;
      });
      if (isGuest) {
        authResult = await _auth.signInAnonymously();
        pushHome(authResult);
      } else if (isLogin) {
        authResult = await _auth.signInWithEmailAndPassword(
          email: email,
          password: password,
        );
        pushHome(authResult);
      } else {
        authResult = await _auth.createUserWithEmailAndPassword(
          email: email,
          password: password,
        );

        final ref = FirebaseStorage.instance
            .ref()
            .child('user_image')
            .child(authResult.user.uid + '.jpg');

        await ref.putFile(image);

        final url = await ref.getDownloadURL();
        final usersCollection = FirebaseFirestore.instance.collection('users');
        var newUser = {
            authResult.user.uid: {
              'username': username,
              'email': email,
              'image_url': url,
            }
          };
        await usersCollection.add(newUser);
        pushHome(authResult);
      }
    } on PlatformException catch (err) {
      var message = 'An error occurred, pelase check your credentials!';

      if (err.message != null) {
        message = err.message;
      }

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(message),
          backgroundColor: Theme.of(ctx).errorColor,
        ),
      );
      setState(() {
        _isLoading = false;
      });
    } catch (err) {
      print(err);
      setState(() {
        _isLoading = false;
      });
    }
  }

  Future<void> createUser(UserCredential authResult, Map<String, String> newUser) => FirebaseFirestore.instance.collection('users').doc(authResult.user.uid).set(newUser);

  void pushHome(UserCredential authResult) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => SplashScreen(authResult)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: AuthForm(
        _submitAuthForm,
        _isLoading,
      ),
    );
  }
}
