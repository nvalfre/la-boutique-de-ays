import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../Feed.dart';
import '../GuestFeed.dart';
import '../Home.dart';
import 'router_constants.dart';

class RouterMapping {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case homeRoute:
        return MaterialPageRoute(builder: (_) => LoginStrategy());
      case adminFeedRoute:
        return MaterialPageRoute(builder: (_) => Feed());
      case guestFeedRoute:
        return MaterialPageRoute(builder: (_) => GuestFeed());
      case userFeedRoute:
        return MaterialPageRoute(builder: (_) => Feed());
      case productDetailsCRUD:
        return MaterialPageRoute(builder: (_) => Feed());
      case productDetailsBuyer:
        return MaterialPageRoute(builder: (_) => Feed());
      case productDetailsGuest:
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