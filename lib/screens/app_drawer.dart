import 'package:flutter/material.dart';
import 'package:la_boutique_de_a_y_s_app/providers/authentication_provider.dart';

class AppDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: <Widget>[
          AppBar(
            title: Text('La boutique de AyS'),
            automaticallyImplyLeading: false,
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.shop),
            title: Text('Productos'),
            onTap: () {
             // Navigator.of(context).pushReplacementNamed('/');
            },
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.category_outlined),
            title: Text('Categorias'),
            onTap: () {
             // Navigator.of(context).pushReplacementNamed(OrdersScreen.routeName);
            },
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.edit),
            title: Text('Editar Productos'),
            onTap: () {
            // Navigator.of(context).pushReplacementNamed(UserProductsScreen.routeName);
            },
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.exit_to_app),
            title: Text('Salir'),
            onTap: () {
              Navigator.of(context).pop();
              Navigator.of(context).pushReplacementNamed('/');
              
              // Navigator.of(context)
              //     .pushReplacementNamed(UserProductsScreen.routeName);
              AuthProvider.getState().signOut();
            },
          ),
        ],
      ),
    );
  }
}
