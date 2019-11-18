import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:masihokeh/main.dart';
import 'package:masihokeh/services/usermanagement.dart';

class StorePage extends StatefulWidget {
  final String toolbarname;

  StorePage({Key key, this.toolbarname}) : super(key: key);

  @override
  State<StatefulWidget> createState() => Store(toolbarname);
}

class Store extends State<StorePage> {
  SharedPreferences prefrences;
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  bool loading;

  bool switchValue = false;
  bool masihokeh = false;
  String nama;
  String kota;
  String photoUrl;
  String uid;
  @override
  void initState() {
    super.initState();
    cekmasihokeh();
  }

  Future cekmasihokeh() async {
    prefrences = await SharedPreferences.getInstance();
    setState(() {
      loading = true;
    });
    uid = prefrences.getString("id");

    if (uid != null) {
      final QuerySnapshot result = await Firestore.instance
          .collection("masihokeh")
          .where("uid", isEqualTo: uid)
          .getDocuments();
      final List<DocumentSnapshot> documents = result.documents;
      if (documents.length == 0) {
        await prefrences.setBool("masihokeh", false);

        print(documents.length);
        setState(() {
          masihokeh = false;
        });
      } else {
        await prefrences.setBool("masihokeh", true);

        setState(() {
          nama = documents[0]['nama'];
          photoUrl = documents[0]['photourl'] ??
              "https://www.fakenamegenerator.com/images/sil-male.png";
          kota = documents[0]['kota'];
          masihokeh = true;
        });
      }
      setState(() {
        loading = false;
      });
    } else {}
  }

  jadimasihokeh(BuildContext context) {
    Application.router.navigateTo(context, "/newmasihokeh");
  }

  // String toolbarname = 'Fruiys & Vegetables';
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  String toolbarname;

  Store(this.toolbarname);

  @override
  Widget build(BuildContext context) {
    if (loading == false) {
      if (masihokeh) {
        return Scaffold(
            key: _scaffoldKey,
            appBar: new AppBar(
              leading: IconButton(
                color: Colors.black,
                onPressed: () {
                  Application.router.pop(context);
                },
                icon: Icon(Icons.arrow_back),
              ),
              backgroundColor: Colors.white,
              centerTitle: true,
              title: Text(
                "My Store",
                style: TextStyle(
                    color: Colors.black,
                    fontFamily: "openbold",
                    fontSize: 18.0),
              ),
            ),
            body: Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  SizedBox(
                    height: 8.0,
                  ),
                  SizedBox(
                    height: 8.0,
                  ),
                  Card(
                    color: Theme.of(context).accentColor,
                    child: Container(
                        height: 100.0,
                        alignment: Alignment.topLeft,
                        margin: EdgeInsets.only(top: 7.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            new Row(
                              children: <Widget>[
                                _verticalD(),
                                CircleAvatar(
                                    maxRadius: 30.0,
                                    backgroundImage: NetworkImage(photoUrl ??
                                        "https://www.fakenamegenerator.com/images/sil-male.png")),
                                SizedBox(
                                  width: 10.0,
                                ),
                                new GestureDetector(
                                  onTap: () {
                                    /*Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => signup_screen()));*/
                                  },
                                  child: new Text(
                                    nama ?? "Refresh halaman ini",
                                    style: TextStyle(
                                        fontSize: 22.0,
                                        color: Colors.black87,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                                Expanded(child: Container()),
                                IconButton(
                                  icon: Icon(Icons.settings),
                                  onPressed: () {},
                                )
                              ],
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 60.0),
                              child: Text(
                                kota ?? "Refresh halaman ini",
                                style: TextStyle(
                                    fontSize: 18.0,
                                    color: Colors.black87,
                                    fontWeight: FontWeight.normal),
                              ),
                            ),
                          ],
                        )),
                  ),
                  SizedBox(
                    height: 25.0,
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 10.0),
                    child: Card(
                        child: Container(
                      //  padding: EdgeInsets.only(left: 10.0,top: 15.0,bottom: 5.0,right: 5.0),

                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Container(
                              padding: EdgeInsets.only(
                                  left: 10.0, top: 15.0, bottom: 15.0),
                              child: GestureDetector(
                                child: Row(
                                  children: <Widget>[
                                    Icon(Icons.add, color: Colors.black54),
                                    Container(
                                      margin: EdgeInsets.only(left: 10.0),
                                    ),
                                    Text(
                                      'Add Product',
                                      style: TextStyle(
                                        fontSize: 17.0,
                                        color: Colors.black87,
                                      ),
                                    ),
                                  ],
                                ),
                                onTap: () {
                                  Application.router
                                      .navigateTo(context, "/addproduk");
                                },
                              )),
                          Divider(
                            height: 5.0,
                          ),
                          Container(
                              padding: EdgeInsets.only(
                                  left: 10.0, top: 15.0, bottom: 15.0),
                              child: GestureDetector(
                                  child: Row(
                                    children: <Widget>[
                                      Icon(FontAwesomeIcons.cartArrowDown,
                                          color: Colors.black54),
                                      Container(
                                        margin: EdgeInsets.only(left: 10.0),
                                      ),
                                      Text(
                                        'Order Confirmation',
                                        style: TextStyle(
                                            fontSize: 17.0,
                                            color: Colors.black87),
                                      ),
                                    ],
                                  ),
                                  onTap: () {
                                    Application.router
                                        .navigateTo(context, "/orderin");
                                  })),
                          Divider(
                            height: 5.0,
                          ),
                          Container(
                              padding: EdgeInsets.only(
                                  left: 10.0, top: 15.0, bottom: 15.0),
                              child: GestureDetector(
                                  child: Row(
                                    children: <Widget>[
                                      Icon(Icons.history,
                                          color: Colors.black54),
                                      Container(
                                        margin: EdgeInsets.only(left: 10.0),
                                      ),
                                      Text(
                                        'Order History',
                                        style: TextStyle(
                                            fontSize: 17.0,
                                            color: Colors.black87),
                                      ),
                                    ],
                                  ),
                                  onTap: () {
                                    Application.router
                                        .navigateTo(context, "/history2");
                                  })),
                          Container(
                              padding: EdgeInsets.only(
                                  left: 10.0, top: 15.0, bottom: 15.0),
                              child: GestureDetector(
                                  child: Row(
                                    children: <Widget>[
                                      Icon(FontAwesomeIcons.qrcode,
                                          color: Colors.black54),
                                      Container(
                                        margin: EdgeInsets.only(left: 10.0),
                                      ),
                                      Text(
                                        ' Scan QR Code',
                                        style: TextStyle(
                                            fontSize: 17.0,
                                            color: Colors.black87),
                                      ),
                                    ],
                                  ),
                                  onTap: () {
                                    Application.router
                                        .navigateTo(context, "/scanqr");
                                  })),
                        ],
                      ),
                    )),
                  )
                ],
              ),
            ));
      } else {
        return Scaffold(
          appBar: new AppBar(
            elevation: 0.0,
            leading: IconButton(
              color: Colors.black,
              onPressed: () {
                Application.router.pop(context);
              },
              icon: Icon(Icons.arrow_back),
            ),
            backgroundColor: Colors.white,
            centerTitle: true,
            title: Text(
              "My Store",
              style: TextStyle(
                  color: Colors.black, fontFamily: "openbold", fontSize: 18.0),
            ),
          ),
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Text(
                    "Do you want to open a store?",
                    style: TextStyle(fontSize: 28.0),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: MaterialButton(
                    child: Text(
                      "Open a store",
                      style: TextStyle(color: Colors.white),
                    ),
                    onPressed: () {
                      jadimasihokeh(context);
                    },
                    color: Colors.blueGrey,
                  ),
                )
              ],
            ),
          ),
        );
      }
    } else {
      return Scaffold(
        appBar: new AppBar(
          leading: IconButton(
            color: Colors.black,
            onPressed: () {
              Application.router.pop(context);
            },
            icon: Icon(Icons.arrow_back),
          ),
          backgroundColor: Colors.white,
          centerTitle: true,
          title: Text(
            "My Store",
            style: TextStyle(
                color: Colors.black, fontFamily: "openbold", fontSize: 18.0),
          ),
        ),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Container(
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation(Colors.grey),
              ),
            ),
          ),
        ),
      );
    }
  }

  void showDemoDialog<T>({BuildContext context, Widget child}) {
    showDialog<T>(
      context: context,
      builder: (BuildContext context) => child,
    ).then<void>((T value) {
      // The value passed to Navigator.pop() or null.
      if (value != null) {
        /*_scaffoldKey.currentState.showSnackBar(SnackBar(
            content: Text('You selected: $value')
        ));*/
      }
    });
  }

  _verticalD() => Container(
        margin: EdgeInsets.only(left: 10.0, right: 0.0, top: 0.0, bottom: 0.0),
      );
}
