import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:la_boutique_de_a_y_s_app/domain/product.dart';
import 'package:la_boutique_de_a_y_s_app/providers/product_provider.dart';
import 'package:la_boutique_de_a_y_s_app/widgets/products/product_item_grid.dart';
import 'package:url_launcher/url_launcher.dart';

class HomeBody extends StatefulWidget {

  @override
  _HomeBodyState createState() => _HomeBodyState();
}

class _HomeBodyState extends State<HomeBody> {
  bool showFavs;

  String url = "www.facebook.com";

  @override
  Widget build(BuildContext context) {
    final productsData = ProductProvider.getState();
    //List<ProductBO>  products = showFavs ? productsData.getProductFavoriteList() : productsData.getProductListBO();
    return Column(
      children: [
        Container(
          child: ClipRRect(
            borderRadius: BorderRadius.circular(15.0),
            child: FadeInImage(
              image: AssetImage('assets/logo/la-boutique-de-ays.gif'),
              placeholder: AssetImage('assets/images/no-image.png'),
              fit: BoxFit.cover,
              width: 100,
            ),
          ),
        ),
        StreamBuilder(
            stream: productsData.getProducts(),
            builder:
                (BuildContext context, AsyncSnapshot<List<Product>> snapshot) {
              if (snapshot.hasData) {
                return productListView(snapshot);
                //return productGrid(snapshot);
              } else {
                return Container(
                    height: 100.0,
                    child: Center(child: CircularProgressIndicator()));
              }
            }),
        Expanded(
          child: Align(
            alignment: Alignment.bottomCenter,
            child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 100, left: 22),
                  child: Text("Buscanos en nuestras redes: ", style: Theme.of(context).textTheme.subtitle2),
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
          ),
        ),
      ],
    );
  }

  _launchURLApp(url) async {
    if (await canLaunch(url)) {
      await launch(url, forceSafariVC: true, forceWebView: true);
    } else {
      throw 'Could not launch $url';
    }
  }

  _launchURLBrowser(url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
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
    );
  }
}
