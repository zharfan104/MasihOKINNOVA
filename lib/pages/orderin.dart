import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:masihokeh/komponen/SingleCardProduk.dart';
import 'package:masihokeh/main.dart';
import 'package:masihokeh/models/ItemProduk.dart';

class OrderIn extends StatefulWidget {
  final page;

  const OrderIn({Key key, this.page}) : super(key: key);

  @override
  OrderInState createState() => OrderInState();
}

class OrderInState extends State<OrderIn> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
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
          "Order Confirmation",
          style: TextStyle(
              color: Colors.black, fontWeight: FontWeight.bold, fontSize: 20.0),
        ),
      ),
      body: Column(
        children: <Widget>[
          Expanded(child: Container(color: Colors.white, child: OderHistory2()))
        ],
      ),
    );
  }
}

class OderHistory2 extends StatefulWidget {
  final String toolbarname;

  OderHistory2({Key key, this.toolbarname}) : super(key: key);

  @override
  State<StatefulWidget> createState() => Oderhistory2();
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

class Oderhistory2 extends State<OderHistory2> {
  String uid;
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
      return Scaffold(
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
    } else {
      return StreamBuilder(
          stream: Firestore.instance
              .collection("order")
              .where("produsenID", isEqualTo: uid)
              .snapshots(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            } else {
              if (snapshot.data.documents.length == 0 ||
                  snapshot.data.documents == null) {
                return Center(
                  child: Text("You have no order."),
                );
              } else {
                return new ListView.builder(
                  itemCount: snapshot.data.documents.length,
                  itemBuilder: (BuildContext context, int index) {
                    bool isCancel = snapshot.data.documents[index]["iscancel"];
                    bool isDone = snapshot.data.documents[index]["isdone"];
                    if (isCancel || isDone) {
                      return Container();
                    } else {
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
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
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
                                              fontSize: 16.0,
                                              fontStyle: FontStyle.normal,
                                              color: Colors.black87,
                                            ),
                                          ),
                                        ),

                                        Container(
                                          margin: EdgeInsets.only(top: 3.0),
                                        ),
                                        Container(
                                          alignment: Alignment.topLeft,
                                          child: Text(
                                            "${snapshot.data.documents[index]["jamambil1"]} - ${snapshot.data.documents[index]["jamambil2"]}" ??
                                                "lok1",
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
                                                          color:
                                                              Colors.black54),
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
                                                      'Harga',
                                                      style: TextStyle(
                                                          fontSize: 13.0,
                                                          color:
                                                              Colors.black54),
                                                    ),
                                                    Container(
                                                      margin: EdgeInsets.only(
                                                          top: 3.0),
                                                      child: Text(
                                                        "Rp. ${snapshot.data.documents[index]["harga"]}" ??
                                                            "lok3",
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
                                                      'Jenis Pembayaran',
                                                      style: TextStyle(
                                                          fontSize: 13.0,
                                                          color:
                                                              Colors.black54),
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

                                        Divider(
                                          height: 10.0,
                                          color: Colors.amber.shade500,
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceAround,
                                          children: <Widget>[
                                            InkWell(
                                              onTap: () {
                                                String key = uid +
                                                    "-" +
                                                    snapshot.data
                                                            .documents[index]
                                                        ["produkID"];
                                                print(key);
                                                Firestore.instance
                                                    .collection("order")
                                                    .document(key)
                                                    .updateData({
                                                  "iscancel": true,
                                                  "israted": true
                                                });
                                                Fluttertoast.showToast(
                                                    msg: "Order Cancelled");
                                              },
                                              child: Container(
                                                decoration: BoxDecoration(
                                                    color: Colors.red,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            20.0)),
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.all(4.0),
                                                  child: Row(
                                                    children: <Widget>[
                                                      Icon(
                                                        Icons.cancel,
                                                        color: Colors.white,
                                                      ),
                                                      Text(
                                                        " Cancel Order",
                                                        style: TextStyle(
                                                            color:
                                                                Colors.white),
                                                      )
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            )
                                          ],
                                        )
                                      ],
                                    ))))),
                      ]));
                    }
                  },
                );
              }
            }
          });
    }
  }
}
