import 'package:la_boutique_de_a_y_s_app/consts/my_icons.dart';
import 'package:la_boutique_de_a_y_s_app/screens/search.dart';
import 'package:la_boutique_de_a_y_s_app/screens/user_info.dart';
import 'package:flutter/material.dart';

import 'cart/cart.dart';
import 'feeds.dart';
import 'home.dart';

class BottomBarScreen extends StatefulWidget {
  static const routeName = '/BottomBarScreen';

  @override
  _BottomBarScreenState createState() => _BottomBarScreenState();
}

class _BottomBarScreenState extends State<BottomBarScreen>
    with SingleTickerProviderStateMixin {
  int _selectedPageIndex = 1;
  List<Object> pages;
  TabController _tabController;

  final List<Widget> listIcons = [
    Tab(icon: Icon(Icons.home)),
    Tab(icon: Icon(Icons.rss_feed_rounded)),
    //  Tab(icon: Icon(Icons.search)),
    Tab(icon: Icon(Icons.shopping_cart_rounded)),
    Tab(icon: Icon(Icons.account_circle_outlined)),
  ];

  @override
  void initState() {
    pages = [
      Home(),
      Marketplace(),
      //  Search(),
      CartScreen(),
      UserInfo(),
    ];
    _tabController = TabController(length: pages.length, vsync: this);

    super.initState();
  }

  TabBarView getTabBarView(tabController) {
    return TabBarView(
      controller: tabController,
      children: [
        Center(child: pages[0]),
        Center(child: pages[1]),
        //Center(child: pages[2]),
        Center(child: pages[2]),
        Center(child: pages[3]),
      ],
    );
  }

  void _selectPage(int index) {
    setState(() {
      _selectedPageIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: getTabBarView(_tabController),
      appBar: AppBar(
        bottom: TabBar(
          controller: _tabController,
          isScrollable: true,
          tabs: listIcons,
          indicator: UnderlineTabIndicator(
              borderSide: BorderSide(width: 2.0, color: Colors.white),
              insets: EdgeInsets.symmetric(horizontal: 0.0)),
          indicatorWeight: 4.0,
          labelPadding: EdgeInsets.only(left: 30.0, right: 30.0),
        ),
        title: Center(child: buildLogo()),
      ),
      floatingActionButtonLocation:
          FloatingActionButtonLocation.miniCenterDocked,
      floatingActionButton: Padding(
        padding: const EdgeInsets.all(8.0),
        child: FloatingActionButton(
          backgroundColor: Colors.purple,
          hoverElevation: 10,
          splashColor: Colors.grey,
          tooltip: 'Search',
          elevation: 4,
          child: Icon(MyAppIcons.search),
          onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) {
            return Search();
          })),
        ),
      ),
    );
  }

  static FadeInImage buildLogo() {
    return FadeInImage(
      width: 50,
      height: 50,
      image: AssetImage('assets/logo/la-boutique-logo.gif'),
      placeholder: AssetImage('assets/logo/la-boutique-logo.gif'),
      fit: BoxFit.cover,
    );
  }
}
