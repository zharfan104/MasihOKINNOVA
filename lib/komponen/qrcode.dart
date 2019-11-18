import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

class Qrcode extends StatefulWidget {
  final String orderID;
  const Qrcode({Key key, this.orderID}) : super(key: key);

  @override
  _QrcodeState createState() => _QrcodeState();
}

class _QrcodeState extends State<Qrcode> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: Firestore.instance
            .collection("order")
            .where("orderID", isEqualTo: widget.orderID)
            .snapshots(),
        builder: (context, snapshot) {
          bool isWait = (snapshot.connectionState == ConnectionState.waiting);

          if (isWait && !snapshot.hasData) {
            return AlertDialog(
              content: CircularProgressIndicator(),
            );
          } else {
            bool isDone = snapshot.data.documents[0]["isdone"];
            print(snapshot.data.documents[0]["namauser"]);

            return Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 50.0, vertical: 50.0),
              child: AlertDialog(
                  title: isDone
                      ? Column(
                          children: <Widget>[
                            new Text(
                              "Congratulations!",
                              style: new TextStyle(
                                color: Colors.black,
                                fontFamily: "bold",
                                fontSize: 22.0,
                              ),
                            ),
                            SizedBox(
                              height: 12.0,
                            ),
                          ],
                        )
                      : Column(
                          children: <Widget>[
                            new Text(
                              "Your QrCode!",
                              style: new TextStyle(
                                color: Colors.black,
                                fontFamily: "bold",
                                fontSize: 22.0,
                              ),
                            ),
                            SizedBox(
                              height: 12.0,
                            ),
                            new Text(
                              "Show this QR Code to the Seller",
                              style: new TextStyle(
                                color: Colors.black,
                                fontFamily: "bold",
                                fontSize: 12.0,
                              ),
                            )
                          ],
                        ),
                  content: isDone
                      ? Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          mainAxisSize: MainAxisSize.max,
                          children: <Widget>[
                            new Text(
                              "Thank you!, you just saved the earth from food waste.",
                              style: new TextStyle(
                                color: Colors.black,
                                fontFamily: "bold",
                                fontSize: 20.0,
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 10.0),
                              child: new Text(
                                "Here's  +${snapshot.data.documents[0]["jumlah"] * 10} Bonus Points for you!",
                                style: new TextStyle(
                                  color: Colors.black,
                                  fontFamily: "bold",
                                  fontSize: 20.0,
                                ),
                              ),
                            ),
                          ],
                        )
                      : Column(
                          children: <Widget>[
                            SizedBox(
                              height: 50.0,
                            ),
                            Container(
                              height: 200.0,
                              width: 200.0,
                              child: new QrImage(
                                data: widget.orderID,
                                size: 200.0,
                              ),
                            ),
                          ],
                        ),
                  actions: <Widget>[
                    new Padding(
                      padding: new EdgeInsets.only(bottom: 8.0, right: 8.0),
                      child: new FlatButton(
                          onPressed: () {
                            Navigator.of(context).pop(true);
                          },
                          child: new Text(
                            "OK",
                            style: TextStyle(
                              color: Colors.black,
                              fontFamily: "openbold",
                            ),
                          )),
                    ),
                  ]),
            );
          }
        });
  }
}
