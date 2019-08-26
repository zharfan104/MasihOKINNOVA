import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:masihokeh/main.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';

class ScanQR extends StatefulWidget {
  final page;

  const ScanQR({Key key, this.page}) : super(key: key);

  @override
  ScanQRState createState() => ScanQRState();
}

class ScanQRState extends State<ScanQR> {
  String result = "Template";

  String password;
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
          "Pindai QRCode",
          style: TextStyle(
              color: Colors.black, fontWeight: FontWeight.bold, fontSize: 30.0),
        ),
      ),
      body: Column(
        children: <Widget>[
          SizedBox(
            height: 48.0,
          ),
          Padding(
            padding: const EdgeInsets.all(30.0),
            child: InkWell(
              onTap: () {},
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10.0),
                    border: Border.all(
                        style: BorderStyle.solid,
                        color: Colors.black,
                        width: 3.0)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Center(
                      child: Text(
                        "Tap to scan QR code",
                        style: TextStyle(fontSize: 22.0),
                      ),
                    ),
                    Icon(
                      Icons.camera,
                      size: 50,
                    )
                  ],
                ),
                height: 400.0,
                width: MediaQuery.of(context).size.width,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
