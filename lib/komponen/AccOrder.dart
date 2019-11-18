import 'package:auto_size_text/auto_size_text.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:masihokeh/main.dart';
import 'package:uuid/uuid.dart';

class Accorder extends StatefulWidget {
  final String produkID;
  final String pembeliID;
  final String harga;
  final String nama;
  final String namaprodusen;

  final String jamambil1;
  final String jamambil2;
  final String alamat;

  final String photomasihokeh;

  const Accorder(
      {Key key,
      this.produkID,
      this.pembeliID,
      this.harga,
      this.nama,
      this.jamambil1,
      this.jamambil2,
      this.alamat,
      this.photomasihokeh,
      this.namaprodusen})
      : super(key: key);
  @override
  _AccorderState createState() => _AccorderState(produkID, pembeliID, harga,
      nama, jamambil1, jamambil2, alamat, namaprodusen, photomasihokeh);
}

class _AccorderState extends State<Accorder> {
  String produkID;
  String pembeliID;
  String harga;

  String nama;

  String namaprodusen;
  String namauser;

  final String jamambil1;
  final String jamambil2;
  int hargaint;
  String alamat;
  SharedPreferences prefrences;
  String uid;
  String photomasihokeh;
  var uuid = new Uuid();
  String orderKey;
  int jumlah = 1;
  _AccorderState(
      this.produkID,
      this.pembeliID,
      this.harga,
      this.nama,
      this.jamambil1,
      this.jamambil2,
      this.alamat,
      this.namaprodusen,
      this.photomasihokeh);
  Future handleBeli() async {
    prefrences = await SharedPreferences.getInstance();
    uid = prefrences.getString("id");
    namauser = prefrences.getString("nama");

    orderKey = uid + "-" + produkID;
    print(nama + namaprodusen);
    await Firestore.instance
        .collection("produk")
        .document(nama + namaprodusen)
        .updateData({"jumlah": FieldValue.increment(-1 * jumlah)});
    await Firestore.instance.collection("order").document(orderKey).setData({
      "produkID": produkID,
      "nama": nama,
      "jumlah": jumlah,
      "iscancel": false,
      "israted": false,
      "isdone": false,
      "pembeliID": uid,
      "namauser": namauser,
      "harga": hargaint.toString(),
      "produsenID": produkID.split("-")[1],
      "alamat": alamat,
      "jamambil1": jamambil1,
      "jamambil2": jamambil2,
      "orderID": uuid.v1().substring(30),
      "namaprodusen": namaprodusen,
      "photomasihokeh": photomasihokeh
    });
    Fluttertoast.showToast(
        msg: "Order Successful,Check your cart to see your qr code.");
    Application.router.navigateTo(context, "/landing");
  }

  @override
  void initState() {
    super.initState();
    hargaint = int.parse(harga);
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(32.0))),
      title: new Text(
        "Order Confirmation",
        style: new TextStyle(
          color: Colors.black,
          fontFamily: "bold",
          fontSize: 22.0,
        ),
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Row(
            children: <Widget>[
              Text(
                "Product Name : ",
                style: TextStyle(
                    color: Colors.black,
                    fontFamily: "bold",
                    fontWeight: FontWeight.bold),
              ),
            ],
          ),
          SizedBox(height: 40.0, width: 200.0, child: AutoSizeText("$nama")),
          Row(
            children: <Widget>[
              Text(
                "Address : ",
                style: TextStyle(
                    color: Colors.black,
                    fontFamily: "bold",
                    fontWeight: FontWeight.bold),
              ),
            ],
          ),
          SizedBox(height: 50.0, width: 200.0, child: AutoSizeText("$alamat")),
          Row(
            children: <Widget>[
              Text(
                "Time to Take : ",
                style: TextStyle(
                    color: Colors.black,
                    fontFamily: "bold",
                    fontWeight: FontWeight.bold),
              ),
            ],
          ),
          SizedBox(
              height: 20.0,
              width: 200.0,
              child: AutoSizeText("$jamambil1 - $jamambil2")),
          Row(
            children: <Widget>[
              Text(
                "Order: ",
                style: TextStyle(
                    color: Colors.black,
                    fontFamily: "bold",
                    fontWeight: FontWeight.bold),
              ),
              Expanded(
                child: Container(),
              ),
              IconButton(
                icon: Icon(
                  FontAwesomeIcons.minus,
                  color: Colors.black,
                ),
                onPressed: () {
                  setState(() {
                    if (jumlah > 1) {
                      jumlah--;
                      hargaint = int.parse(harga) * jumlah;
                    }
                  });
                },
              ),
              Text(jumlah.toString()),
              IconButton(
                icon: Icon(
                  FontAwesomeIcons.plus,
                  color: Colors.black,
                ),
                onPressed: () {
                  setState(() {
                    jumlah++;
                    hargaint = int.parse(harga) * jumlah;
                  });
                },
              ),
            ],
          ),
          Row(
            children: <Widget>[
              Text(
                "Price Total : ",
                style: TextStyle(
                    color: Colors.black,
                    fontFamily: "bold",
                    fontWeight: FontWeight.bold),
              ),
              Expanded(
                child: Container(),
              ),
              Text(
                "${hargaint.toString()}",
                style:
                    TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
              )
            ],
          )
        ],
      ),
      actions: <Widget>[
        new Padding(
          padding: new EdgeInsets.only(bottom: 8.0, right: 8.0),
          child: new MaterialButton(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0)),
              color: Colors.red,
              onPressed: () {
                Navigator.of(context).pop(true);
              },
              child: new Text(
                "Cancel",
                style: TextStyle(
                  color: Colors.white,
                  fontFamily: "openbold",
                ),
              )),
        ),
        new Padding(
          padding: new EdgeInsets.only(bottom: 8.0, right: 8.0),
          child: new MaterialButton(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0)),
              color: Theme.of(context).accentColor,
              onPressed: () {
                handleBeli();
              },
              child: new Text(
                "Order!",
                style: TextStyle(
                  color: Colors.white,
                  fontFamily: "openbold",
                ),
              )),
        ),
      ],
    );
  }
}
