import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:loading_gifs/loading_gifs.dart';

import '../shared_preferences/shared_prefs_constants.dart';
import '../domain/product.dart';
import '../shared_preferences/user_preferences.dart';

class ProductCardSwipper extends StatelessWidget {
  UserPreferences _prefs = UserPreferences();
  final List<Product> itemList;
  final Function siguientePagina;

  ProductCardSwipper({@required this.itemList, @required this.siguientePagina});

  final _pageController = new PageController(initialPage: 1, viewportFraction: 0.3);

  @override
  Widget build(BuildContext context) {
    final _screenSize = MediaQuery.of(context).size;

    _pageController.addListener(() {
      if (_pageController.position.pixels >=
          _pageController.position.maxScrollExtent - 200) {
        siguientePagina();
      }
    });

    return Container(
        height: _screenSize.height * 0.15,
        child: PageView.builder(
          pageSnapping: false,
          controller: _pageController,
          itemCount: itemList.length,
          itemBuilder: (context, i) => _card(context, itemList[i]),
        ));
  }

  Widget _card(BuildContext context, Product cardItem) {
    cardItem.id = '${cardItem.id}-card-item';

    final tarjeta = Container(
      margin: EdgeInsets.only(right: 10.0),
      child: Column(
        children: <Widget>[
          Hero(
            tag: cardItem.id,
            child: ClipRRect(
                borderRadius: BorderRadius.circular(15.0),
                child: isAvatarPresent(cardItem)
                    ? loadImageWithFadeIn(cardItem.avatar)
                    : noImageCovered()),
          ),
          SizedBox(height: 5.0),
          Text(
            cardItem.name,
            overflow: TextOverflow.ellipsis,
            style: Theme.of(context).textTheme.caption,
          ),
        ],
      ),
    );

    return GestureDetector(
      child: tarjeta,
      onTap: () {
        _prefs.saveMap(selectedProductKey, cardItem.toJson());
        //Navigator.push(
        //  context, null
        //  //MaterialPageRoute(builder: (context) => RootHomeNavBar(2)),
        //);
      },
    );
  }

  bool isAvatarPresent(cardItem) => cardItem.attributes != null && cardItem.avatar != "";

  Image noImageCovered() {
    return Image(
                image: noImage(),
                height: 80.0,
                fit: BoxFit.cover,
              );
  }

  FadeInImage loadImageWithFadeIn(String image) {
    return FadeInImage.assetNetwork(
                image: image,
                placeholderScale: 10,
                placeholder: circularProgressIndicator,
                fit: BoxFit.cover,
                height: 80.0,
              );
  }

  AssetImage noImage() => AssetImage('assets/images/no-image.png');
}