import 'package:flutter/material.dart';

import 'package:la_boutique_de_a_y_s_app/bloc/auth_bloc.dart';

class Provider extends InheritedWidget {
  static Provider _instance;
  final _authBloc = new AuthBloc();

  factory Provider({Key key, Widget child}) {
    if (_instance == null) {
      _instance = new Provider._internal(key: key, child: child);
    }
    return _instance;
  }

  Provider._internal({Key key, Widget child}) : super(key: key, child: child);

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) => true;

  static Provider getProvider(BuildContext context) =>
      context.dependOnInheritedWidgetOfExactType<Provider>();

  static AuthBloc authBloc(BuildContext context) =>
      getProvider(context)._authBloc;
}
