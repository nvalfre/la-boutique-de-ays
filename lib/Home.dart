import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'domain/enums/auth_status.dart';
import 'providers/authentication_provider.dart';
import 'router/router_constants.dart';

class LoginStrategy extends StatefulWidget {
  LoginStrategy();

  @override
  State<StatefulWidget> createState() => new _LoginStrategyState();
}

class _LoginStrategyState extends State<LoginStrategy> {
  final _authProvider = AuthProvider.getState();
  AuthStatus authStatus = AuthStatus.NOT_DETERMINED;
  String _userId = "";

  @override
  void initState() {
    super.initState();
    new Future.delayed(
        const Duration(milliseconds: 1500), () => {currentUser()});
  }

  Future<void> currentUser() async {
    //var currentUser = _authProvider.getCurrentUser();

   //if (currentUser != null) {
   //  _userId = currentUser?.uid;
   //} else {
   //  var guest = await _authProvider.logInGuest();
   //  currentUser = guest.user;
   //}
    var guest = await _authProvider.logInGuest();
    var currentUser = guest.user;

    setState(() {
      if (currentUser.isAnonymous) {
        authStatus = AuthStatus.ANONYMOUS;
      } else {
        authStatus = currentUser?.uid == null
            ? AuthStatus.NOT_LOGGED_IN
            : AuthStatus.LOGGED_IN;
      }
      switchStatement();
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
            image: AssetImage('assets/logo/la-boutique-de-ays.jpeg'),
            placeholder: AssetImage('assets/logo/la-boutique-de-ays.jpeg'),
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
    const delay = Duration(milliseconds: 500);
    switch (authStatus) {
      case AuthStatus.NOT_DETERMINED:
        break;
      case AuthStatus.ANONYMOUS:
        Future.delayed(
          delay,
          () => Navigator.pushReplacementNamed(context, guestFeedRoute),
        );
        break;
      case AuthStatus.NOT_LOGGED_IN:
        Future.delayed(
          delay,
          () => Navigator.pushReplacementNamed(context, homeRoute),
        );
        break;
      case AuthStatus.LOGGED_IN:
        if (_userId.length > 0 && _userId != null) {
          Future.delayed(
            delay,
            () => Navigator.pushReplacementNamed(context, userFeedRoute),
          );
        }
        break;
    }
  }
}
