import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:masihokeh/komponen/orderhistory_screen.dart';
import 'package:masihokeh/main.dart';

import 'logind_signup.dart';

class ScanQR extends StatefulWidget {
  final page;

  const ScanQR({Key key, this.page}) : super(key: key);

  @override
  ScanQRState createState() => ScanQRState();
}

class ScanQRState extends State<ScanQR> {
  String result = "Template";
  String _scanBarcode = 'Unknown';
  String nama = "";
  String namapembeli = "";
  String id = "";
  String pembeliID = "";

  bool loading = false;
  String harga = "";
  bool isLoading = false;
  int jumlah = 0;

  Future<void> scanBarcodeNormal() async {
    String barcodeScanRes;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
          "#ff6666", "Cancel", true, ScanMode.QR);
      print(barcodeScanRes);

      var document = await Firestore.instance
          .collection('order')
          .where('orderID', isEqualTo: barcodeScanRes);
      await document.getDocuments().then((data) {
        // print(data.documents[0]['namauser']);
        if (data.documents.length > 0) {
          Fluttertoast.showToast(
              msg: "This Order is Valid",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIos: 1,
              backgroundColor: Colors.black,
              textColor: Colors.white,
              fontSize: 16.0);
          nama = data.documents[0].data['nama'];
          print(nama);
          namapembeli = data.documents[0].data['namauser'];
          pembeliID = data.documents[0].data['pembeliID'];
          harga = data.documents[0].data['harga'];
          jumlah = data.documents[0].data['jumlah'];
          id = data.documents[0].documentID;
        }
      });
      await Firestore.instance
          .collection("users")
          .document(pembeliID)
          .updateData({"poin": FieldValue.increment(10 * jumlah)});
    } on PlatformException {
      barcodeScanRes = 'Failed to get platform version.';
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in  flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      _scanBarcode = barcodeScanRes;
      nama = nama;
      jumlah = jumlah;
      namapembeli = namapembeli;
      harga = harga;
    });
  }

  String password;
  @override
  Widget build(BuildContext context) {
    if (_scanBarcode == "Unknown" || _scanBarcode == "-1") {
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
            "Scan QRCode",
            style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 30.0),
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
                onTap: () => scanBarcodeNormal(),
                child: Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10.0),
                      border: Border.all(
                          style: BorderStyle.solid,
                          color: Colors.black,
                          width: 3.0)),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Icon(
                          FontAwesomeIcons.qrcode,
                          size: 50,
                        ),
                      ),
                      Center(
                        child: Text(
                          "Tap to scan QR code",
                          style: TextStyle(fontSize: 22.0),
                        ),
                      ),
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
    } else {
      if (loading) {
        return Wait();
      } else {
        return buildDoneScan(context);
      }
    }
  }

  _buttonClicked() async {
    await Firestore.instance
        .collection("order")
        .document(id)
        .updateData({"isdone": true});
    Application.router.navigateTo(context, "/landing");
  }

  Scaffold buildDoneScan(BuildContext context) {
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
            "Order Details",
            style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 30.0),
          ),
        ),
        body: SingleChildScrollView(
          padding:
              EdgeInsets.only(left: 20.0, right: 20.0, top: 40.0, bottom: 10.0),
          child: Column(
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text("Product Name"),
                  Text("$nama"),
                ],
              ),
              SizedBox(
                height: 10.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text("Name"),
                  Text("$namapembeli"),
                ],
              ),
              SizedBox(
                height: 10.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    "Total",
                  ),
                  Text(
                    "$jumlah",
                  ),
                ],
              ),

              SizedBox(
                height: 10.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    "Total Price",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text(
                    "$harga",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              SizedBox(
                height: 20.0,
              ),
              // SizedBox(
              //   child: Container(),
              // ),
              Container(
                  color: Colors.grey.shade200,
                  padding: EdgeInsets.all(8.0),
                  width: double.infinity,
                  child: Text("Payment Option".toUpperCase())),
              RadioListTile(
                groupValue: true,
                value: true,
                title: Text("Cash on Delivery"),
                onChanged: (value) {},
              ),

              Container(
                width: double.infinity,
                height: 50.0,
                child: RaisedButton(
                  color: Colors.grey[800],
                  onPressed: () async {
                    setState(() {
                      isLoading = true;
                    });
                    print(isLoading);

                    await _buttonClicked();
                    setState(() {
                      isLoading = false;
                    });
                    print(isLoading);
                  },
                  child: Center(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        isLoading
                            ? Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 12.0),
                                child: CircularProgressIndicator(),
                              )
                            : Container(),
                        Text(
                          "Proceed Transaction",
                          style: TextStyle(
                              fontWeight: isLoading
                                  ? FontWeight.bold
                                  : FontWeight.normal,
                              color: Colors.white),
                        ),
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        ));
  }
}
