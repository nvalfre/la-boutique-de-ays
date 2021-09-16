import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:la_boutique_de_a_y_s_app/models/product.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter/foundation.dart';

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
      child: ElevatedButton(
        style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(Colors.blueAccent),
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30.0),
                side: BorderSide(color: Colors.blueAccent),
              ),
            )),
        onPressed: () => openwhatsapp(context),
        child: Container(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Container(
                    width: 22,
                    height: 22,
                    child: Image(
                        image: AssetImage('assets/images/whatsapp-logo.png'))),
              ),
              Text(
                "COMPRAR",
                style: TextStyle(fontSize: 16, color: Colors.white),
              )
            ],
          ),
        ),
      ),
    );
  }

  openwhatsapp(BuildContext context) async {
    const whatsappPhone = "+5493513702010";
    var parsedTextUri = Uri.parse(parse(list));
    var android =
        "whatsapp://send?phone=" + whatsappPhone + "&text=${parsedTextUri}";
    var ios = "https://wa.me/$whatsappPhone?text=${parsedTextUri}";
    final wspNotInstalled = "No tienes instalado WhatsApp";
    if (kIsWeb) {
      await launchAndroidOrWeb(android, context, wspNotInstalled);
    } else {
      if (Platform.isIOS) {
        await launchIos(ios, context, wspNotInstalled);
      } else {
        await launchAndroidOrWeb(android, context, wspNotInstalled);
      }
    }
  }

  String parse(List<Product> list) {
    String productData = "";
    productData += list.length > 1
        ? 'Hola! me interesan estos productos:\n'
        :  'Hola! me interesa este producto:\n';
    list.forEach((element) {
      productData += 'Producto: ${element.title}\n ';
      productData += 'Descripción: ${element.description}\n ';
      productData += 'Precio: ${element.price}\n ';
      productData += 'Marca: ${element.brand}\n ';
      productData += 'Cantidad: ${element.quantity}\n\n ';
    });
    productData += '¿Me podrias dar mas información? \n'
        'Gracias!';
    return productData;
  }

  Future<void> launchIos(
      String ios, BuildContext context, String wspNotInstalled) async {
    if (await canLaunch(ios)) {
      await launch(ios, forceSafariVC: false);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: new Text(wspNotInstalled),
        backgroundColor: Colors.red,
      ));
    }
  }

  Future<void> launchAndroidOrWeb(
      String android, BuildContext context, String wspNotInstalled) async {
    if (await canLaunch(android)) {
      await launch(android);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: new Text(wspNotInstalled), backgroundColor: Colors.red));
    }
  }
}
