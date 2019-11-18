import 'package:auto_size_text/auto_size_text.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:masihokeh/pages/chat/chat.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:masihokeh/main.dart';

class OderHistory extends StatefulWidget {
  final String toolbarname;

  OderHistory({Key key, this.toolbarname}) : super(key: key);

  @override
  State<StatefulWidget> createState() => Oderhistory();
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

class Oderhistory extends State<OderHistory> {
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
              .where("pembeliID", isEqualTo: uid)
              .where("iscancel", isEqualTo: false)
              .where("isdone", isEqualTo: false)
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
                  return SafeArea(
                      child: Column(children: <Widget>[
                    Container(
                        margin:
                            EdgeInsets.only(left: 5.0, right: 5.0, bottom: 5.0),
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
                                                  margin:
                                                      EdgeInsets.only(top: 3.0),
                                                  child: Text(
                                                    "#${snapshot.data.documents[index]["orderID"]}" ??
                                                        "lok2",
                                                    style: TextStyle(
                                                        fontSize: 15.0,
                                                        color: Colors.black87),
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
                                                  margin:
                                                      EdgeInsets.only(top: 3.0),
                                                  child: Text(
                                                    "Rp. ${snapshot.data.documents[index]["harga"]}" ??
                                                        "harga",
                                                    style: TextStyle(
                                                        fontSize: 15.0,
                                                        color: Colors.black87),
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
                                                  margin:
                                                      EdgeInsets.only(top: 3.0),
                                                  child: Text(
                                                    "COD",
                                                    style: TextStyle(
                                                        fontSize: 15.0,
                                                        color: Colors.black87),
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
                                          MainAxisAlignment.spaceAround,
                                      children: <Widget>[
                                        Container(
                                            child: FlatButton(
                                          child: Text("Check QR code"),
                                          onPressed: () {
                                            orderID = snapshot.data
                                                .documents[index]["orderID"];
                                            Application.router.navigateTo(
                                                context,
                                                "/qrcode?orderID=$orderID");
                                          },
                                        )),
                                        Container(
                                            alignment: Alignment.center,
                                            child: FlatButton(
                                              child: Text("Chat Seller"),
                                              onPressed: () async {
                                                List<dynamic> idbuyer = [
                                                  snapshot.data.documents[index]
                                                      ["pembeliID"]
                                                ];
                                                List<dynamic> idseller = [
                                                  snapshot.data.documents[index]
                                                      ["produsenID"]
                                                ];
                                                print(snapshot
                                                        .data.documents[index]
                                                    ["photourl"]);
                                                await gotoChat(
                                                    idbuyer, idseller);
                                                Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder:
                                                            (context) => Chat(
                                                                  peerId: snapshot
                                                                          .data
                                                                          .documents[index]
                                                                      [
                                                                      "produsenID"],
                                                                  peerAvatar: snapshot
                                                                          .data
                                                                          .documents[index]
                                                                      [
                                                                      "photomasihokeh"],
                                                                  nama: snapshot
                                                                          .data
                                                                          .documents[index]
                                                                      [
                                                                      "namaprodusen"],
                                                                )));
                                              },
                                            )),
                                      ],
                                    ),

                                    Container(
                                      width: 130.0,
                                      child: InkWell(
                                        onTap: () {
                                          String key = uid +
                                              "-" +
                                              snapshot.data.documents[index]
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
                                              msg:
                                                  "Pemesanan Berhasil Dibatalkan");
                                        },
                                        child: Container(
                                          decoration: BoxDecoration(
                                              color: Colors.red,
                                              borderRadius:
                                                  BorderRadius.circular(20.0)),
                                          child: Padding(
                                            padding: const EdgeInsets.all(4.0),
                                            child: Row(
                                              children: <Widget>[
                                                Icon(
                                                  Icons.cancel,
                                                  color: Colors.white,
                                                ),
                                                Text(
                                                  " Cancel Order",
                                                  style: TextStyle(
                                                      color: Colors.white),
                                                )
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    )
                                  ],
                                ))))),
                  ]));
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
