import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

class Qrcode extends StatelessWidget {
  final String orderID;

  const Qrcode({Key key, this.orderID}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: new Text(
        "QrCode Anda!",
        style: new TextStyle(
          color: Colors.black,
          fontFamily: "bold",
          fontSize: 22.0,
        ),
      ),
      content: Container(
        height: 250.0,
        width: 250.0,
        child: new QrImage(
          data: orderID,
          size: 200.0,
        ),
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
      ],
    );
  }
}
