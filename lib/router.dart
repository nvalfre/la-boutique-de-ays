import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:la_boutique_de_a_y_s_app/Home.dart';
import 'package:la_boutique_de_a_y_s_app/router_constants.dart';

import 'Feed.dart';

class RouterMapping {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case homeRoute:
        return MaterialPageRoute(builder: (_) => Home());
      case feedRoute:
        return MaterialPageRoute(builder: (_) => Feed());
      default:
        return MaterialPageRoute(
            builder: (_) => Scaffold(
              body: Center(
                  child: Text('No route defined for ${settings.name}')),
            ));
    }
  }
}