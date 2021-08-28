import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:la_boutique_de_a_y_s_app/providers/authentication_service_impl.dart';

import 'domain/enums/auth_status.dart';

class Home extends StatefulWidget {
  Home();

  @override
  State<StatefulWidget> createState() => new _HomeState();
}

class _HomeState extends State<Home> {
  final _authProvider = AuthenticationService.getState();
  AuthStatus authStatus = AuthStatus.NOT_DETERMINED;
  final int splashDuration = 2;
  String _userId = "";

  @override
  void initState() {
    super.initState();
    new Future.delayed(
        const Duration(milliseconds: 2500), () => {currentUser()});
  }

  Future<void> currentUser() async {
    var currentUser = _authProvider.getCurrentUser();

    setState(() {
      if (currentUser != null) {
        _userId = currentUser?.uid;
      }
      authStatus = currentUser?.uid == null
          ? AuthStatus.NOT_LOGGED_IN
          : AuthStatus.LOGGED_IN;
      switchStatement();
    });
  }

  void loginCallback() {
    var currentUser = _authProvider.getCurrentUser();
    setState(() {
      _userId = currentUser.uid.toString();
      authStatus = AuthStatus.LOGGED_IN;
    });
  }

  void logoutCallback() {
    _authProvider.signOut();
    setState(() {
      authStatus = AuthStatus.NOT_LOGGED_IN;
      _userId = "";
    });
  }

  Scaffold backgroundStack() {
    return Scaffold(
        body: Stack(
      children: <Widget>[
        _getBackground(context),
        logoContainer(),
      ],
    ));
  }

  Container logoContainer() {
    return Container(
      child: Column(
        children: <Widget>[
          SizedBox(
            height: 50,
          ),
          FadeInImage(
            image: AssetImage('assets/logo/Logo-Curvas.png'),
            placeholder: AssetImage('assets/images/jar-loading.gif'),
            fit: BoxFit.contain,
            fadeInDuration: Duration(seconds: 1),
            width: 275,
          ),
          SizedBox(width: double.infinity),
          SizedBox(
            height: 25,
          ),
          Container(
              alignment: Alignment.center,
              child: CircularProgressIndicator(
                  valueColor:
                      new AlwaysStoppedAnimation<Color>(Colors.greenAccent)))
        ],
      ),
    );
  }

  Widget _getBackground(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return getBackgroundContainer(size);
  }

  Container getBackgroundContainer(Size size) {
    return Container(
      height: size.height,
      width: double.infinity,
      decoration: BoxDecoration(
          gradient: LinearGradient(colors: <Color>[
        Theme.of(context).primaryColor,
        Theme.of(context).secondaryHeaderColor
      ])),
    );
  }

  TextStyle buildTextStyleForHeader(double size) =>
      TextStyle(color: Colors.white, fontSize: size);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: backgroundStack(),
      ),
    );
  }

  void switchStatement() {
    switch (authStatus) {
      case AuthStatus.NOT_DETERMINED:
        break;
      case AuthStatus.NOT_LOGGED_IN:
        Future.delayed(
          const Duration(seconds: 2),
          () => Navigator.pushReplacementNamed(context, 'login'),
        );
        break;
      case AuthStatus.LOGGED_IN:
        if (_userId.length > 0 && _userId != null) {
          Future.delayed(
            const Duration(seconds: 2),
            () => Navigator.pushReplacementNamed(context, 'root'),
          );
        }
        break;
    }
  }
}
