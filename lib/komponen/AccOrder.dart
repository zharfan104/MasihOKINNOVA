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
  final String jamambil1;
  final String jamambil2;
  final String alamat;
  const Accorder(
      {Key key,
      this.produkID,
      this.pembeliID,
      this.harga,
      this.nama,
      this.jamambil1,
      this.jamambil2,
      this.alamat})
      : super(key: key);
  @override
  _AccorderState createState() => _AccorderState(
      produkID, pembeliID, harga, nama, jamambil1, jamambil2, alamat);
}

class _AccorderState extends State<Accorder> {
  String produkID;
  String pembeliID;
  String harga;
  String nama;
  final String jamambil1;
  final String jamambil2;
  int hargaint;
  String alamat;
  SharedPreferences prefrences;
  String uid;
  var uuid = new Uuid();
  String orderKey;
  int jumlah = 1;
  _AccorderState(this.produkID, this.pembeliID, this.harga, this.nama,
      this.jamambil1, this.jamambil2, this.alamat);
  Future handleBeli() async {
    print("$alamat bangsat");
    prefrences = await SharedPreferences.getInstance();
    uid = prefrences.getString("id");
    orderKey = uid + "-" + produkID;

    Firestore.instance.collection("order").document(orderKey).setData({
      "produkID": produkID,
      "pembeliID": uid,
      "harga": hargaint.toString(),
      "produsenID": produkID.split("-")[1],
      "alamat": alamat,
      "jamambil1": jamambil1,
      "jamambil2": jamambil2,
      "orderID": uuid.v1().substring(30)
    });
    Fluttertoast.showToast(
        msg: "Pembelian berhasil, silahkan cek keranjang untuk melihat QRcode");
    Application.router.navigateTo(context, "/landing");
  }

  @override
  void initState() {
    super.initState();
    print(produkID);
    hargaint = int.parse(harga);
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: new Text(
        "Konfirmasi Pembelian",
        style: new TextStyle(
          color: Colors.black,
          fontFamily: "bold",
          fontSize: 22.0,
        ),
      ),
      content: Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              Text(
                "Jumlah Pesan",
                style: TextStyle(
                    color: Colors.black,
                    fontFamily: "bold",
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(
                width: 20.0,
              ),
              IconButton(
                icon: Icon(
                  FontAwesomeIcons.plus,
                  color: Colors.grey,
                ),
                onPressed: () {
                  setState(() {
                    jumlah++;
                    hargaint = int.parse(harga) * jumlah;
                  });
                },
              ),
              Text(jumlah.toString()),
              IconButton(
                icon: Icon(
                  FontAwesomeIcons.minus,
                  color: Colors.grey,
                ),
                onPressed: () {
                  setState(() {
                    if (jumlah > 1) {
                      jumlah--;
                      hargaint = int.parse(harga) * jumlah;
                    }
                  });
                },
              )
            ],
          ),
          Text("harga ${hargaint.toString()}")
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
                "Beli!",
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
