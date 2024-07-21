import 'package:coffe_app/Components/bottom_navbar.dart';
import 'package:coffe_app/Model/coffee.dart';
import 'package:coffe_app/Model/coffee_shope.dart';
// import 'package:coffe_app/Components/coffee_tile.dart';
import 'package:coffe_app/Pages/cart_page.dart';
import 'package:coffe_app/Pages/shop_page.dart';
import 'package:coffe_app/const.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'about_page.dart';

class HomePage extends StatefulWidget {
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;

  void navigateBottomNavBar(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  final List _pages = [
    ShopPage(),
    CartPage(),
  ];

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      bottomNavigationBar: MyBottomNavBar(onTabChanged: navigateBottomNavBar),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: Builder(
          builder: (context) => IconButton(
            icon: Padding(
              padding: EdgeInsets.all(14),
              child: Icon(Icons.menu, color: Colors.black),
            ),
            onPressed: () {
              Scaffold.of(context).openDrawer();
            },
          ),
        ),
      ),
      drawer: Drawer(
        backgroundColor: backgroundColor,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                SizedBox(
                  height: 80,
                ),
                Image.asset(
                  "lib/images/espresso.png",
                  height: 160,
                ),
                Padding(
                  padding: EdgeInsets.all(25),
                  child: Divider(
                    color: Colors.white,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 25),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => HomePage(),
                        ),
                      );
                    },
                    child: ListTile(
                      leading: Icon(Icons.home),
                      title: Text('Home'),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => AboutPage(),
                      ),
                    );
                  },
                  child: Padding(
                    padding: EdgeInsets.only(left: 25),
                    child: ListTile(
                      leading: Icon(Icons.info),
                      title: Text('About'),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => AboutPage(),
                      ),
                    );
                  },
                  child: Padding(
                    padding: EdgeInsets.only(left: 25),
                    child: ListTile(
                      leading: Icon(Icons.admin_panel_settings_rounded),
                      title: Text('Manage Products'),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      body: _pages[_selectedIndex],
    );
  }
}
