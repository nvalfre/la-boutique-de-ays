import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'domain/enums/user_role.dart';
import 'domain/product.dart';
import 'product_card.dart';
import 'providers/product_provider.dart';
import 'router/router_constants.dart';
import 'shared_preferences/user_preferences.dart';
class GuestFeed extends StatefulWidget {
  GuestFeed();

  @override
  State<StatefulWidget> createState() => new _GuestFeedState();
}

class _GuestFeedState extends State<GuestFeed> {
  var productProvider = ProductProvider.getState(); //TODO BLOC
  Product _product;
  File _photo;
  UserPreferences _prefs = UserPreferences();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: Text('La boutique de A y S'),
        backgroundColor: Theme.of(context).primaryColor,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.search),
            //onPressed: () {
            //  showSearch(
            //    context: context,
            //    delegate: DataSearchReservas(),
            //  );
            //},
          ),
        ],
      ),
      //drawer: UserDrawer(),
      body: SingleChildScrollView(
          child: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.all(1.0),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Container(
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      _swiperTarjetas(productProvider),
                      _detailsColumn(productProvider),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      )),
    );
  }

  renderSnapshotData(
      AsyncSnapshot<dynamic> snapshot, renderFunction, BuildContext context) {}

  Widget _swiperTarjetas(ProductProvider productProvider) {
    return Container(
      padding: EdgeInsets.only(top: 10),
      child: StreamBuilder(
        stream: productProvider.getProducts(), //loadbyclub
        builder: (BuildContext context, AsyncSnapshot<List<Product>> snapshot) {
          if (snapshot.hasData) {
            return Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                      padding: EdgeInsets.only(left: 20.0),
                      child: Text('Productos',
                          style: Theme.of(context).textTheme.subtitle1)),
                  SizedBox(height: 5.0),
                  ProductCardSwipper(
                    itemList: snapshot.data,
                    siguientePagina: productProvider.getProducts,
                  ),
                ],
              ),
            );
          } else {
            return Container(
                height: 100.0,
                child: Center(child: CircularProgressIndicator()));
          }
        },
      ),
    );
  }

  Widget _detailsColumn(ProductProvider productProvider) {
    return Container(
      padding: EdgeInsets.only(top: 20),
      child: Column(
        children: <Widget>[
          Divider(
            thickness: 1,
            height: 3,
          ),
          SizedBox(
            height: 5,
          ),
          SingleChildScrollView(
            child: Column(
              children: <Widget>[
                //_getImageRow(productProvider), //TODO
                SizedBox(height: 10.0),
                // _prefs.role == AccessStatus.USER ? Container() :_getEditButton(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Container _getImageRow(ProductProvider productProvider) {
    return Container(
      padding: EdgeInsets.only(right: 5, left: 5),
      child: Row(
        children: <Widget>[
          GestureDetector(
              child: _showLogo(),
              onTap: () => pushByRolePref(productDetailsBuyer,
                  productDetailsGuest, productDetailsCRUD)),
          Flexible(
              child: Container(
                  padding: EdgeInsets.only(left: 10),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      StreamBuilder(
                          stream: productProvider.getProduct(_product.id),
                          builder: (BuildContext context,
                              AsyncSnapshot<Product> snapshot) {
                            return snapshot.hasData
                                ? Text("Product: ${snapshot.data.name}",
                                    style: Theme.of(context).textTheme.title,
                                    overflow: TextOverflow.ellipsis,
                                    textAlign: TextAlign.justify)
                                : Text("Product: cargando...");
                          }),
                      Text("Prestacion: ${_product.name}",
                          style: Theme.of(context).textTheme.button),
                      SizedBox(
                        height: 5,
                      ),
                      Text("Descripcion: ${_product.description}",
                          style: Theme.of(context).textTheme.button),
                      _getAvailable()
                    ],
                  )))
        ],
      ),
    );
  }

  Widget _showLogo() {
    if (_photo != null) {
      return Container(
        margin: EdgeInsets.only(right: 10.0),
        child: Column(
          children: <Widget>[
            Hero(
              tag: _product.id ?? '', //TODO unique id?
              child: ClipRRect(
                borderRadius: BorderRadius.circular(15.0),
                child: FadeInImage(
                  image: FileImage(_photo),
                  placeholder: AssetImage('assets/images/no-image.png'),
                  fit: BoxFit.cover,
                  width: 50,
                ),
              ),
            ),
          ],
        ),
      );
    }
    if (_product != null && _product.avatar != null && _product.avatar != "") {
      return _fadeInImageFromNetworkWithJarHolder();
    } else {
      return Image(
        image: AssetImage('assets/images/no-image.png'),
        height: 50.0,
        fit: BoxFit.cover,
      );
    }
  }

  Widget _fadeInImageFromNetworkWithJarHolder() {
    return InkWell(
      child: new Container(
        width: 100.0,
        height: 100.0,
        alignment: Alignment.center,
        decoration: new BoxDecoration(
          image: DecorationImage(
              image: NetworkImage(_product.avatar), fit: BoxFit.fill),
        ),
      ),
      onTap: () => pushByRolePref(
          productDetailsBuyer, productDetailsGuest, productDetailsCRUD),
    );
  }

  Future<Object> pushByRolePref(
      String buyerRouter, String guestRoute, String crudRoute) {
    return _prefs.userRole == UserRole.BUYER
        ? Navigator.pushNamed(context, buyerRouter, arguments: _product)
        : _prefs.userRole == UserRole.GUEST
            ? Navigator.pushNamed(context, guestRoute, arguments: _product)
            : _prefs.userRole == UserRole.ADMIN
                ? Navigator.pushNamed(context, crudRoute, arguments: _product)
                : null;
  }

  _getAvailable() {
    String status = _product.getStatus();
    return Container(
      padding: EdgeInsets.only(right: 10, left: 10),
      child: RichText(
        text: TextSpan(
          children: [
            TextSpan(
                text: 'Estado: ' + status,
                style: Theme.of(context).textTheme.button),
          ],
        ),
      ),
    );
  }
}
