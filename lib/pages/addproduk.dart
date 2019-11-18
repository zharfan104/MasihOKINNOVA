import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:masihokeh/main.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';

class AddProduk extends StatefulWidget {
  final page;

  const AddProduk({Key key, this.page}) : super(key: key);

  @override
  AddProdukState createState() => AddProdukState();
}

class AddProdukState extends State<AddProduk> {
  String nama;
  String hargaawal;
  String hargasekarang;
  String waktuawal;
  String waktusekarang;
  String deskripsiproduk;
  String namamasihokeh;
  String alamatmasihokeh;
  String logomasihokeh;
  String photomasihokeh;
  String kota;

  // Create a text controller. We will use it to retrieve the current value
  // of the TextField!
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  final controllernama = TextEditingController();
  final controllerhargaawal = TextEditingController();
  final controllerhargasekarang = TextEditingController();
  final controllerdeskripsi = TextEditingController();

  final controllerjumlah = TextEditingController();
  File _image;
  bool loading = false;
  String filename;

  Future getImage() async {
    var image = await ImagePicker.pickImage(source: ImageSource.gallery);
    setState(() {
      _image = image;
    });
  }

  Future<void> tambahProduk() async {
    final FirebaseUser user = await firebaseAuth.currentUser();
    StorageReference ref = FirebaseStorage.instance
        .ref()
        .child(user.uid)
        .child(controllernama.text);
    setState(() {
      loading = true;
    });
    StorageUploadTask uploadTask = ref.putFile(_image);
    final StorageTaskSnapshot downloadUrl = await uploadTask.onComplete;
    String url = await downloadUrl.ref.getDownloadURL();
    print('URL Is $url');

    if (user != null) {
      final QuerySnapshot result = await Firestore.instance
          .collection("masihokeh")
          .where("uid", isEqualTo: user.uid)
          .getDocuments();
      final List<DocumentSnapshot> documents = result.documents;
      namamasihokeh = documents[0]['nama'];
      alamatmasihokeh = documents[0]['alamat'];
      photomasihokeh = documents[0]['photourl'];
      kota = documents[0]['kota'];
      Firestore.instance
          .collection("produk")
          .document(controllernama.text + namamasihokeh)
          .setData({
        "uid": user.uid,
        "searchKey": controllernama.text.substring(0, 1).toUpperCase(),
        "nama": controllernama.text[0].toUpperCase() +
            controllernama.text.substring(1),
        "hargaawal": controllerhargaawal.text,
        "hargasekarang": controllerhargasekarang.text,
        "deskripsi": controllerdeskripsi.text,
        "waktuambil1": date1.toString(),
        "waktuambil2": date2.toString(),
        "namamasihokeh": namamasihokeh,
        "alamatmasihokeh": alamatmasihokeh,
        "photomasihokeh": photomasihokeh,
        "photo": url,
        "jumlah": int.parse(controllerjumlah.text),
        "kota": kota[0].toUpperCase() + kota.substring(1)
      });
      Application.router.navigateTo(context, "/landing");
      Fluttertoast.showToast(msg: "Berhasil Menambah Produk");
      setState(() {
        loading = false;
      });
    }
  }

  @override
  void dispose() {
    // Clean up the controller when the Widget is removed from the Widget tree
    controllernama.dispose();
    controllerdeskripsi.dispose();
    controllerhargaawal.dispose();
    controllerhargasekarang.dispose();

    super.dispose();
  }

  final formats = {
    InputType.both: DateFormat("EEEE, MMMM d, yyyy 'at' h:mma"),
    InputType.date: DateFormat('yyyy-MM-dd'),
    InputType.time: DateFormat("HH:mm"),
  };

  // Changeable in demo
  InputType inputType = InputType.both;
  bool editable = true;
  DateTime date1;
  DateTime date2;

  void updateInputType({bool date, bool time}) {
    date = date ?? inputType != InputType.time;
    time = time ?? inputType != InputType.date;
    setState(() => inputType =
        date ? time ? InputType.both : InputType.date : InputType.time);
  }

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
          "Add Product",
          style: TextStyle(color: Colors.black, fontSize: 20.0),
        ),
        elevation: 0.0,
      ),
      body: ListView(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: GestureDetector(
              onTap: getImage,
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10.0),
                    border: Border.all(
                        style: BorderStyle.solid,
                        color: Colors.blueGrey,
                        width: 3.0)),
                child: _image == null
                    ? Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Center(
                            child: Text(
                              "Tap to add product photos",
                              style: TextStyle(fontSize: 20.0),
                            ),
                          ),
                          Icon(
                            Icons.photo,
                            size: 50,
                          )
                        ],
                      )
                    : Image.file(
                        _image,
                        fit: BoxFit.cover,
                      ),
                height: 150.0,
                width: MediaQuery.of(context).size.width,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: TextField(
              controller: controllernama,
              decoration: const InputDecoration(
                  border: UnderlineInputBorder(
                    borderSide: BorderSide(
                        color: Colors.black87, style: BorderStyle.solid),
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                        color: Colors.black87, style: BorderStyle.solid),
                  ),
                  icon: Icon(
                    FontAwesomeIcons.dotCircle,
                    color: Colors.black38,
                  ),
                  hintText: 'Enter the product name',
                  labelText: 'Product Name',
                  labelStyle: TextStyle(color: Colors.black54)),
              keyboardType: TextInputType.text,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: controllerhargaawal,
              decoration: const InputDecoration(
                  border: UnderlineInputBorder(
                    borderSide: BorderSide(
                        color: Colors.black87, style: BorderStyle.solid),
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                        color: Colors.black87, style: BorderStyle.solid),
                  ),
                  icon: Icon(
                    FontAwesomeIcons.tag,
                    color: Colors.black38,
                  ),
                  hintText: 'Estimated Real Price',
                  labelText: 'Before Price',
                  labelStyle: TextStyle(color: Colors.black54)),
              keyboardType: TextInputType.number,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: controllerhargasekarang,
              decoration: const InputDecoration(
                  border: UnderlineInputBorder(
                    borderSide: BorderSide(
                        color: Colors.black87, style: BorderStyle.solid),
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                        color: Colors.black87, style: BorderStyle.solid),
                  ),
                  icon: Icon(
                    FontAwesomeIcons.tag,
                    color: Colors.black38,
                  ),
                  hintText: 'After Price',
                  labelText: 'After Price',
                  labelStyle: TextStyle(color: Colors.black54)),
              keyboardType: TextInputType.number,
            ),
          ),
          DateTimePickerFormField(
            inputType: inputType,
            format: formats[inputType],
            editable: editable,
            decoration: InputDecoration(
                icon: Icon(FontAwesomeIcons.clock),
                labelText: 'Pick Up Time 1',
                hasFloatingPlaceholder: true),
            onChanged: (dt) => setState(() => date1 = dt),
          ),
          Center(
            child: Text(
              "-",
              style: TextStyle(fontSize: 38.0, color: Colors.grey),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
              left: 12.0,
              right: 10.0,
            ),
            child: DateTimePickerFormField(
              inputType: inputType,
              format: formats[inputType],
              editable: editable,
              decoration: InputDecoration(
                  icon: Icon(FontAwesomeIcons.clock),
                  labelText: 'Pick Up Time 2',
                  hasFloatingPlaceholder: true),
              onChanged: (dt) => setState(() => date2 = dt),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: TextField(
              controller: controllerdeskripsi,
              maxLines: 5,
              decoration: const InputDecoration(
                  hintMaxLines: 5,
                  border: UnderlineInputBorder(
                    borderSide: BorderSide(
                        color: Colors.black87, style: BorderStyle.solid),
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                        color: Colors.black87, style: BorderStyle.solid),
                  ),
                  icon: Icon(
                    FontAwesomeIcons.stickyNote,
                    color: Colors.black38,
                  ),
                  hintText: 'Product Description',
                  labelText: 'Product Description',
                  labelStyle: TextStyle(color: Colors.black54)),
              keyboardType: TextInputType.text,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: TextField(
              controller: controllerjumlah,
              decoration: const InputDecoration(
                  border: UnderlineInputBorder(
                    borderSide: BorderSide(
                        color: Colors.black87, style: BorderStyle.solid),
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                        color: Colors.black87, style: BorderStyle.solid),
                  ),
                  icon: Icon(
                    FontAwesomeIcons.chevronCircleDown,
                    color: Colors.black38,
                  ),
                  hintText: '51',
                  labelText: 'Stock',
                  labelStyle: TextStyle(color: Colors.black54)),
              keyboardType: TextInputType.number,
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Visibility(
            visible: loading ?? true,
            child: Center(
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation(Colors.grey),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Center(
              child: MaterialButton(
                  color: Colors.black87,
                  child: Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Text(
                      "Add Product",
                      style: TextStyle(color: Colors.white, fontSize: 16),
                    ),
                  ),
                  onPressed: () {
                    if (_image == null) {
                      Fluttertoast.showToast(msg: "Tolong pilih foto produk");
                    } else {
                      tambahProduk();
                    }
                  }),
            ),
          ),
          SizedBox(
            height: 5.0,
          )
        ],
      ),
    );
  }
}
