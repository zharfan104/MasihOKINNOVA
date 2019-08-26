import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:masihokeh/komponen/Drawer.dart';

import 'package:masihokeh/pages/Cart.dart';
import 'package:masihokeh/pages/ExplorePage.dart';
import 'package:masihokeh/pages/HomePage.dart';

class LandingPage extends StatefulWidget {
  final Widget child;
  final String email;
  final String nama;
  final String photourl;

  const LandingPage({Key key, this.email, this.nama, this.photourl, this.child})
      : super(key: key);

  _LandingPageState createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage>
    with SingleTickerProviderStateMixin {
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  SharedPreferences prefrences;

  GlobalKey bottomNavigationKey = GlobalKey();
  TabController controller;
  double listViewOffset = 0.0;

  @override
  void initState() {
    super.initState();
    controller = TabController(initialIndex: 1, vsync: this, length: 3);
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  int currentPage = 0;
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: DrawerKu(),
        bottomNavigationBar: Material(
            color: Color(0xFF36E06C).withOpacity(0.1),
            textStyle: TextStyle(fontSize: 15.0),
            child: TabBar(
                labelStyle:
                    TextStyle(fontSize: 15.0, fontWeight: FontWeight.bold),
                labelPadding: EdgeInsets.all(0.5),
                indicatorPadding: EdgeInsets.all(0.5),
                controller: controller,
                indicatorColor: Colors.black,
                labelColor: Colors.green,
                unselectedLabelColor: Theme.of(context).accentColor,
                indicatorSize: TabBarIndicatorSize.tab,
                indicator: UnderlineTabIndicator(
                  borderSide: BorderSide(
                      color: Colors.green,
                      style: BorderStyle.solid,
                      width: 3.0),
                ),
                tabs: <Widget>[
                  Tab(
                    icon: Icon(
                      Icons.near_me,
                      size: 30.0,
                    ),
                  ),
                  Tab(
                      icon: Icon(
                    Icons.home,
                    size: 30.0,
                  )),
                  Tab(
                      icon: Icon(
                    Icons.shopping_cart,
                    size: 30.0,
                  ))
                ])),
        body: TabBarView(
            physics: NeverScrollableScrollPhysics(),
            controller: controller,
            children: <Widget>[
              StatefulListView(
                getOffsetMethod: () => listViewOffset,
                setOffsetMethod: (offset) => this.listViewOffset = offset,
              ),
              ExplorePage(),
              Cart()
            ]));
  }
}
