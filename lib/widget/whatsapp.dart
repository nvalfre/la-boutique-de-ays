import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:la_boutique_de_a_y_s_app/models/product.dart';
import 'package:url_launcher/url_launcher.dart';

class OpenWhatsapp extends StatelessWidget {
  List<Product> list;

  OpenWhatsapp(List<Product> list) {
    this.list = list;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      width: 100,
      child: GestureDetector(
        onTap: () {
          openwhatsapp(context);
        },
        child: Container(
          color: Colors.white,
          child: Row(
            children: [
              Image(image: AssetImage('assets/images/whatsapp-logo.jpg'),
              ),
              Text(
                "COMPRAR",
                style: TextStyle(fontSize: 16, color: Colors.blueAccent),
              )
            ],
          ),
        ),
      ),
    );
  }

  openwhatsapp(BuildContext context) async {
    const whatsappPhone = "+5493517714883";
    var parsedTextUri = Uri.parse(list.toString());
    var android =
        "whatsapp://send?phone=" + whatsappPhone + "&text=${parsedTextUri}";
    var ios = "https://wa.me/$whatsappPhone?text=${parsedTextUri}";
    final wspNotInstalled = "No tienes instalado WhatsApp";
    if (Platform.isIOS) {
      //TODO
      if (await canLaunch(ios)) {
        await launch(ios, forceSafariVC: false);
      } else {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: new Text(wspNotInstalled), backgroundColor: Colors.red,));
      }
    } else {
      if (await canLaunch(android)) {
        await launch(android);
      } else {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: new Text(wspNotInstalled), backgroundColor: Colors.red));
      }
    }
  }
}
