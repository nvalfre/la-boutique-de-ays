import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../domain/enums/user_role.dart';
import '../domain/product.dart';
import '../widgets/product_card.dart';
import '../providers/product_provider.dart';
import '../router/router_constants.dart';
import 'app_drawer.dart';
import 'products_overview_screen.dart';
import '../shared_preferences/user_preferences.dart';
import '../widgets/products/product_item_grid.dart';

class GuestFeed extends StatefulWidget {
  GuestFeed();

  @override
  State<StatefulWidget> createState() => new _GuestFeedState();
}

class _GuestFeedState extends State<GuestFeed> {
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
        title: Center(child: Text('La boutique de AyS')),
        actions: _popUpMenu(),
      ),
      drawer: AppDrawer(),
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: Container(
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      LaBoutiqueLogo(),
                      SocialMediaButtons(context: context),
                      // _swiperTarjetas(),
                      ProductGrid(),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: new FloatingActionButton(
        onPressed: () {},
        child: const Icon(Icons.add),
      ),
    );
  }

  List<Widget> _popUpMenu() => <Widget>[
        PopupMenuButton(
          onSelected: (FilterOptions selectedValue) {
            setState(() {
              if (selectedValue == FilterOptions.Favorites) {
              } else {}
            });
          },
          icon: Icon(
            Icons.more_vert,
          ),
          itemBuilder: (_) => [
            PopupMenuItem(
              child: Text('Favoritos'),
              value: FilterOptions.Favorites,
            ),
            PopupMenuItem(
              child: Text('Todos'),
              value: FilterOptions.All,
            ),
          ],
        ),
      ];

  Widget _swiperTarjetas() {
    final productProvider = ProductProvider.getState();

    return Container(
      padding: EdgeInsets.only(top: 10),
      child: StreamBuilder(
        stream: productProvider.getProducts(),
        builder: (BuildContext context, AsyncSnapshot<List<Product>> snapshot) {
          if (snapshot.hasData) {
            return renderCardSwipperContainer(
                context, snapshot, productProvider);
          } else {
            return Container(
                height: 100.0,
                child: Center(child: CircularProgressIndicator()));
          }
        },
      ),
    );
  }

  Container renderCardSwipperContainer(BuildContext context,
      AsyncSnapshot<List<Product>> snapshot, ProductProvider productProvider) {
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
  }

  Widget _detailsColumn() {
    final productProvider = ProductProvider.getState();
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

class SocialMediaButtons extends StatelessWidget {
  const SocialMediaButtons({
    Key key,
    @required this.context,
  }) : super(key: key);

  final BuildContext context;

  @override
  Widget build(BuildContext context) {
    var text = Text("Buscanos en nuestras redes: ",
        style: Theme.of(context).textTheme.subtitle2);
    return Align(
      alignment: Alignment.bottomCenter,
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 100, left: 22),
            child: text,
          ),
          const Spacer(),
          IconButton(
            color: Colors.pink,
            icon: FaIcon(FontAwesomeIcons.instagram),
            onPressed: () {},
            padding: EdgeInsets.only(bottom: 100),
          ),
          const Spacer(),
          IconButton(
            color: Colors.pink,
            icon: FaIcon(FontAwesomeIcons.facebook),
            onPressed: () {},
            padding: EdgeInsets.only(bottom: 100),
          ),
          const Spacer(),
        ],
      ),
    );
  }
}

class LaBoutiqueLogo extends StatelessWidget {
  const LaBoutiqueLogo({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => Container(
        child: ClipRRect(
          borderRadius: BorderRadius.circular(15.0),
          child: FadeInImage(
            image: AssetImage('assets/logo/la-boutique-logo.gif'),
            placeholder: AssetImage('assets/logo/la-boutique-logo.gif'),
            fit: BoxFit.cover,
            width: 150,
          ),
        ),
      );
}

class ProductGrid extends StatelessWidget {
  const ProductGrid({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final productProvider = ProductProvider.getState();
    return Container(
      child: StreamBuilder(
        stream: productProvider.getProducts(),
        builder: (BuildContext context, AsyncSnapshot<List<Product>> snapshot) {
          if (snapshot.hasData) {
            return productListView(snapshot);
          } else {
            return Container(
                height: 100.0,
                child: Center(child: CircularProgressIndicator()));
          }
        },
      ),
    );
  }

  GridView productGrid(AsyncSnapshot<List<Product>> snapshot) {
    return GridView.builder(
      shrinkWrap: true,
      padding: const EdgeInsets.all(10.0),
      itemCount: snapshot.data.length,
      itemBuilder: (BuildContext ctx, i) {
        return ProductItemGrid(
            snapshot.data[i].id,
            snapshot.data[i].name,
            snapshot.data[i].description,
            snapshot.data[i].price,
            snapshot.data[i].avatar,
            false);
      },
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 3 / 2,
        crossAxisSpacing: 20,
        mainAxisSpacing: 20,
      ),
    );
  }

  ListView productListView(AsyncSnapshot<List<Product>> snapshot) {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: snapshot.data.length,
      itemBuilder: (context, i) => InkWell(
        onTap: () =>{},
        child: _rowWidgetWithNameAndDescriptions(snapshot.data[i], context),
      ),
    );
  }
  _rowWidgetWithNameAndDescriptions(Product product, BuildContext context) {

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          Container(
            height: 125,
            width: 100,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(15),
              child: Image(
                  image: (product.avatar == null)
                      ? AssetImage('assets/images/no-image.png')
                      : NetworkImage(product.avatar),
                  height: 110,
                  fit: BoxFit.contain),
            ),
          ),
          SizedBox(width: 10),
          Flexible(
              child: Column(
                children: <Widget>[
                  Text(product.name,
                      style: Theme
                          .of(context)
                          .textTheme
                          .button),
                  Text(product.description,
                      style: Theme
                          .of(context)
                          .textTheme
                          .button),
                  SizedBox(
                    width: 5,
                  ),
                ],)
          ),
          IconButton(
            icon: Icon(Icons.more_rounded),
            onPressed: () => {},
          )
        ],
      ),
    );
  }
}
