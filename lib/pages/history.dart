import 'package:auto_size_text/auto_size_text.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:masihokeh/main.dart';

class History extends StatefulWidget {
  final page;

  const History({Key key, this.page}) : super(key: key);

  @override
  HistoryState createState() => HistoryState();
}

class HistoryState extends State<History> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.1,
        leading: IconButton(
          onPressed: () {
            Application.router.pop(context);
          },
          icon: Icon(
            Icons.arrow_back,
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
      ),
      body: Column(
        children: <Widget>[
          Container(color: Colors.white, child: MyAppBar()),
          SizedBox(
            height: 10.0,
          ),
          Expanded(
              child:
                  Container(color: Colors.white, child: OrderHistoryPembeli()))
        ],
      ),
    );
  }
}

class MyAppBar extends StatelessWidget {
  const MyAppBar({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          SizedBox(
            height: 25.0,
          ),
          Center(
            child: Text(
              "Order History",
              style: TextStyle(fontSize: 25.0, fontFamily: "openbold"),
            ),
          ),
        ],
      ),
    );
  }
}

class OrderHistoryPembeli extends StatefulWidget {
  final String toolbarname;

  OrderHistoryPembeli({Key key, this.toolbarname}) : super(key: key);

  @override
  State<StatefulWidget> createState() => OrderHistoryPembeliState();
}

class Item {
  final String name;
  final String deliveryTime;
  final String oderId;
  final String oderAmount;
  final String paymentType;
  final String address;
  final String cancelOder;

  Item(
      {this.name,
      this.deliveryTime,
      this.oderId,
      this.oderAmount,
      this.paymentType,
      this.address,
      this.cancelOder});
}

class OrderHistoryPembeliState extends State<OrderHistoryPembeli> {
  String uid;
  String orderID;
  bool loading = false;
  SharedPreferences prefrences;
  Future cekid() async {
    setState(() {
      loading = true;
    });
    prefrences = await SharedPreferences.getInstance();
    uid = prefrences.getString("id");
    setState(() {
      loading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    cekid();
  }

  // String toolbarname = 'Fruiys & Vegetables';
  // final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    if (loading == true) {
      return Wait();
    } else {
      return StreamBuilder(
          stream: Firestore.instance
              .collection("order")
              .where("produsenID", isEqualTo: uid)
              .snapshots(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Wait();
            } else if (snapshot.data.documents.length == 0 ||
                snapshot.data.documents == null) {
              print(snapshot.data.documents);
              return Center(
                child: Text("You have no order."),
              );
            } else {
              return ListView.builder(
                itemCount: snapshot.data.documents.length,
                itemBuilder: (BuildContext context, int index) {
                  bool isCancel = snapshot.data.documents[index]["iscancel"];
                  bool isDone = snapshot.data.documents[index]["isdone"];
                  if (isCancel || isDone) {
                    return SafeArea(
                        child: Column(children: <Widget>[
                      Container(
                          margin: EdgeInsets.only(
                              left: 5.0, right: 5.0, bottom: 5.0),
                          color: Colors.black12,
                          child: Card(
                              elevation: 4.0,
                              child: Container(
                                  padding: const EdgeInsets.fromLTRB(
                                      10.0, 10.0, 10.0, 10.0),
                                  child: GestureDetector(
                                      child: Column(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: <Widget>[
                                      // three line description
                                      Container(
                                        alignment: Alignment.topLeft,
                                        child: Text(
                                          snapshot
                                                      .data
                                                      .documents[index]
                                                          ["produkID"]
                                                      .split("-")[0][0]
                                                      .toUpperCase() +
                                                  snapshot
                                                      .data
                                                      .documents[index]
                                                          ["produkID"]
                                                      .split("-")[0]
                                                      .substring(1) ??
                                              "lok4",
                                          style: TextStyle(
                                            fontSize: 20.0,
                                            fontStyle: FontStyle.normal,
                                            color: Colors.black87,
                                          ),
                                        ),
                                      ),

                                      Container(
                                        alignment: Alignment.topLeft,
                                        child: Text(
                                          'Time to take : ' +
                                              "${snapshot.data.documents[index]["jamambil1"]} - ${snapshot.data.documents[index]["jamambil2"]}",
                                          style: TextStyle(
                                              fontSize: 13.0,
                                              color: Colors.black54),
                                        ),
                                      ),

                                      Divider(
                                        height: 10.0,
                                        color: Colors.amber.shade500,
                                      ),

                                      Row(
                                        mainAxisSize: MainAxisSize.max,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: <Widget>[
                                          Container(
                                              padding: EdgeInsets.all(3.0),
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: <Widget>[
                                                  Text(
                                                    'Order Id',
                                                    style: TextStyle(
                                                        fontSize: 13.0,
                                                        color: Colors.black54),
                                                  ),
                                                  Container(
                                                    margin: EdgeInsets.only(
                                                        top: 3.0),
                                                    child: Text(
                                                      "#${snapshot.data.documents[index]["orderID"]}" ??
                                                          "lok2",
                                                      style: TextStyle(
                                                          fontSize: 15.0,
                                                          color:
                                                              Colors.black87),
                                                    ),
                                                  )
                                                ],
                                              )),
                                          Container(
                                              padding: EdgeInsets.all(3.0),
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: <Widget>[
                                                  Text(
                                                    'Price',
                                                    style: TextStyle(
                                                        fontSize: 13.0,
                                                        color: Colors.black54),
                                                  ),
                                                  Container(
                                                    margin: EdgeInsets.only(
                                                        top: 3.0),
                                                    child: Text(
                                                      "Rp. ${snapshot.data.documents[index]["harga"]}" ??
                                                          "harga",
                                                      style: TextStyle(
                                                          fontSize: 15.0,
                                                          color:
                                                              Colors.black87),
                                                    ),
                                                  ),
                                                ],
                                              )),
                                          Container(
                                              padding: EdgeInsets.all(3.0),
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: <Widget>[
                                                  Text(
                                                    'Payment Type',
                                                    style: TextStyle(
                                                        fontSize: 13.0,
                                                        color: Colors.black54),
                                                  ),
                                                  Container(
                                                    margin: EdgeInsets.only(
                                                        top: 3.0),
                                                    child: Text(
                                                      "COD",
                                                      style: TextStyle(
                                                          fontSize: 15.0,
                                                          color:
                                                              Colors.black87),
                                                    ),
                                                  )
                                                ],
                                              )),
                                        ],
                                      ),
                                      Divider(
                                        height: 10.0,
                                        color: Colors.amber.shade500,
                                      ),

                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: <Widget>[
                                          Icon(
                                            Icons.location_on,
                                            size: 20.0,
                                            color: Colors.amber.shade500,
                                          ),
                                          AutoSizeText(
                                              "${snapshot.data.documents[index]["alamat"]}" ??
                                                  "alamat tidak terdefinisi",
                                              maxLines: 2,
                                              style: TextStyle(
                                                  fontSize: 13.0,
                                                  color: Colors.black54)),
                                        ],
                                      ),
                                      Divider(
                                        height: 10.0,
                                        color: Colors.amber.shade500,
                                      ),

                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: <Widget>[
                                          Text(
                                            isCancel
                                                ? "Order Cancelled"
                                                : "Order Success",
                                            style: TextStyle(
                                                color: Colors.grey,
                                                fontSize: 28),
                                          )
                                        ],
                                      )
                                    ],
                                  ))))),
                    ]));
                  } else {
                    return Container();
                  }
                },
              );
            }
          });
    }
  }
}

class Wait extends StatelessWidget {
  const Wait({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Container(
          child: CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation(Colors.grey),
          ),
        ),
      ),
    );
  }
}

gotoChat(idbuyer, idseller) async {
  print(idbuyer + idseller);
  await Firestore.instance
      .collection('masihokeh')
      .document(idseller[0])
      .updateData({"msgwith": FieldValue.arrayUnion(idbuyer)});
  await Firestore.instance
      .collection('users')
      .document(idbuyer[0])
      .updateData({"msgwith": FieldValue.arrayUnion(idseller)});
  print("ou");
}
