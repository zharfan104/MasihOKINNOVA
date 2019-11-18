import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:masihokeh/main.dart';
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

  const LandingPage({
    Key key,
    this.email,
    this.nama,
    this.photourl,
    this.child,
  }) : super(key: key);

  _LandingPageState createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage>
    with SingleTickerProviderStateMixin {
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  SharedPreferences prefrences;

  GlobalKey bottomNavigationKey = GlobalKey();
  TabController controller;
  double listViewOffset = 0.0;
  String _value = 'Semarang';
  String uid;
  bool masihokeh;
  String namauser;
  void _setValue(String value) => setState(() => _value = value);
  void getData() async {
    prefrences = await SharedPreferences.getInstance();
    uid = prefrences.getString("id");
    masihokeh = prefrences.getBool("masihokeh");
    print("asda $masihokeh");
    namauser = prefrences.getString("nama");
  }

  @override
  void initState() {
    controller = TabController(initialIndex: 1, vsync: this, length: 3);
    getData();
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  // Future _askUser() async {
  //   switch (await showDialog(
  //       context: context,
  //       /*it shows a popup with few options which you can select, for option we
  //       will wait for the user to select the option which it can use with switch cases*/
  //       child: new SimpleDialog(
  //         title: new Text(
  //           'Lokasi',
  //           style: TextStyle(
  //             fontSize: 30.0,
  //             fontWeight: FontWeight.bold,
  //             fontFamily: "Roboto",
  //           ),
  //         ),
  //         children: <Widget>[
  //           new SimpleDialogOption(
  //             child: new Text('Semarang',
  //                 style: TextStyle(
  //                     fontSize: 20.0,
  //                     fontWeight: FontWeight.bold,
  //                     fontFamily: "Roboto")),
  //             onPressed: () {
  //               Navigator.pop(context, Answers.Semarang);
  //             },
  //           ),
  //           new SimpleDialogOption(
  //             child: new Text('Jakarta',
  //                 style: TextStyle(
  //                   fontSize: 20.0,
  //                   fontWeight: FontWeight.bold,
  //                   fontFamily: "Roboto",
  //                 )),
  //             onPressed: () {
  //               Navigator.pop(context, Answers.Jakarta);
  //             },
  //           ),
  //           new SimpleDialogOption(
  //             child: new Text('Yogyakarta',
  //                 style: TextStyle(
  //                   fontSize: 20.0,
  //                   fontWeight: FontWeight.bold,
  //                   fontFamily: "Roboto",
  //                 )),
  //             onPressed: () {
  //               Navigator.pop(context, Answers.Yogyakarta);
  //             },
  //           ),
  //         ],
  //       ))) {
  //     case Answers.Semarang:
  //       _setValue('Semarang');
  //       break;
  //     case Answers.Jakarta:
  //       _setValue('Jakarta');
  //       break;
  //     case Answers.Yogyakarta:
  //       _setValue('Yogyakarta');
  //       break;
  //   }
  // }

  int currentPage = 0;
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  Widget build(BuildContext context) {
    return Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          actions: <Widget>[
            IconButton(
              icon: Icon(
                Icons.chat,
                color: Colors.black,
              ),
              onPressed: () {
                Application.router
                    .navigateTo(context, "/chat?id=$uid&masihokeh=$masihokeh");
              },
            )
          ],
          elevation: 0.1,
          leading: IconButton(
            onPressed: () => _scaffoldKey.currentState.openDrawer(),
            icon: Icon(
              Icons.menu,
              color: Colors.black,
            ),
          ),
          backgroundColor: Colors.white,
          centerTitle: true,
          title: Text(
            "MasihOK",
            style: TextStyle(
                color: Colors.black, fontFamily: "pacifico", fontSize: 30.0),
          ),
          // actions: <Widget>[
          // MaterialButton(
          //   onPressed: _askUser,
          //   child: Text(_value,
          //       style: TextStyle(
          //         color: Colors.black,
          //         fontWeight: FontWeight.bold,
          //         fontFamily: "Roboto",
          //       )),
          // )
          // ],
        ),
        drawer: DrawerKu(
          id: uid,
        ),
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
