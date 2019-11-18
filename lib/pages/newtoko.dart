import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:masihokeh/main.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'dart:async';
import 'package:dropdownfield/dropdownfield.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';

class NewToko extends StatefulWidget {
  final page;

  const NewToko({Key key, this.page}) : super(key: key);

  @override
  NewTokoState createState() => NewTokoState();
}

class NewTokoState extends State<NewToko> {
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  String nama;
  SharedPreferences prefrences;

  String deskripsiproduk;
  String url;
  String urlfix;
  bool loading = false;

  // Create a text controller. We will use it to retrieve the current value
  // of the TextField!
  final controllernama = TextEditingController();
  final controllerdeskripsi = TextEditingController();
  final controlleralamat = TextEditingController();
  final controllerkota = TextEditingController();
  File _image;
  String filename;
  Future getImage() async {
    var image = await ImagePicker.pickImage(source: ImageSource.gallery);

    setState(() {
      _image = image;
    });
  }

  Future<void> jadiToko() async {
    final FirebaseUser user = await firebaseAuth.currentUser();
    StorageReference ref =
        FirebaseStorage.instance.ref().child(user.uid).child("Logo.jpg");
    setState(() {
      loading = true;
    });
    StorageUploadTask uploadTask = ref.putFile(_image);
    final StorageTaskSnapshot downloadUrl = await uploadTask.onComplete;
    String url = await downloadUrl.ref.getDownloadURL();
    print('URL Is $url');
    if (user != null) {
      Firestore.instance
          .collection("users")
          .document(user.uid)
          .updateData({"toko": true});
      prefrences = await SharedPreferences.getInstance();

      await prefrences.setBool('masihokeh', true);

      Firestore.instance.collection("masihokeh").document(user.uid).setData({
        "uid": user.uid,
        "nama": controllernama.text,
        "deskripsi": controllerdeskripsi.text,
        "alamat": controlleralamat.text,
        "jenis": jenismasihokeh,
        "kota": controllerkota.text,
        "photourl": url ??
            'https://lh3.googleusercontent.com/-w3QCBzQqUCo/AAAAAAAAAAI/AAAAAAAAAAA/ACHi3rd9DwiLseAsOIfBpU8cKN85Ex_y8A/mo/photo.jpg'
      });
    }
    Application.router.navigateTo(context, "/landing");
    Fluttertoast.showToast(msg: "Berhasil Membuat Toko");
    setState(() {
      loading = false;
    });
  }

  @override
  void dispose() {
    // Clean up the controller when the Widget is removed from the Widget tree
    controllernama.dispose();
    controllerdeskripsi.dispose();
    controlleralamat.dispose();

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
  String jenismasihokeh = 'Toko Serba Ada';

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
          "Register New Store",
          style: TextStyle(
              color: Colors.black, fontFamily: "openbold", fontSize: 18.0),
        ),
      ),
      body: ListView(
        children: <Widget>[
          Container(
              alignment: Alignment.topCenter,
              child: Container(
                width: 100.0,
                height: 100.0,
                margin: const EdgeInsets.all(10.0),
                // padding: const EdgeInsets.all(3.0),
                child: ClipOval(
                    child: _image == null
                        ? Image.network(urlfix ??
                            'https://lh3.googleusercontent.com/-w3QCBzQqUCo/AAAAAAAAAAI/AAAAAAAAAAA/ACHi3rd9DwiLseAsOIfBpU8cKN85Ex_y8A/mo/photo.jpg')
                        : Image.file(_image)),
              )),
          Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Center(
                child: Text(
                  "Store Logo",
                  style: TextStyle(color: Colors.black54, fontSize: 12.0),
                ),
              )),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 100.0),
            child: FlatButton(
              onPressed: getImage,
              child: Text(
                'Change',
                style: TextStyle(fontSize: 13.0, color: Colors.blueAccent),
              ),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30.0),
                  side: BorderSide(color: Colors.blueAccent)),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              "Store Description",
              style: TextStyle(fontSize: 20.0),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(5.0),
            child: TextField(
              controller: controllernama,
              decoration: const InputDecoration(
                  border: UnderlineInputBorder(
                    borderSide: BorderSide(
                        color: Colors.black87, style: BorderStyle.solid),
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                        color: Colors.black, style: BorderStyle.solid),
                  ),
                  icon: Icon(
                    FontAwesomeIcons.dotCircle,
                    color: Colors.black38,
                  ),
                  hintText: 'Enter your store name',
                  labelText: 'Store Name',
                  labelStyle: TextStyle(color: Colors.black54)),
              keyboardType: TextInputType.text,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(5.0),
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
                        color: Colors.black, style: BorderStyle.solid),
                  ),
                  icon: Icon(
                    FontAwesomeIcons.stickyNote,
                    color: Colors.black38,
                  ),
                  labelText: 'Store Description',
                  hintText: 'EVENT BEM UNDIP, FIGHT FOOD WASTE!',
                  labelStyle: TextStyle(color: Colors.black54)),
              keyboardType: TextInputType.text,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(5.0),
            child: TextField(
              controller: controlleralamat,
              maxLines: 5,
              decoration: const InputDecoration(
                  hintMaxLines: 5,
                  border: UnderlineInputBorder(
                    borderSide: BorderSide(
                        color: Colors.black87, style: BorderStyle.solid),
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                        color: Colors.black, style: BorderStyle.solid),
                  ),
                  icon: Icon(
                    FontAwesomeIcons.stickyNote,
                    color: Colors.black38,
                  ),
                  labelText: 'Store Address',
                  hintText: 'Jl. Pahlawan No.45, Kota Majalengka, Jawa Barat',
                  labelStyle: TextStyle(color: Colors.black54)),
              keyboardType: TextInputType.text,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(5.0),
            child: TextField(
              controller: controllerkota,
              decoration: const InputDecoration(
                  border: UnderlineInputBorder(
                    borderSide: BorderSide(
                        color: Colors.black87, style: BorderStyle.solid),
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                        color: Colors.black, style: BorderStyle.solid),
                  ),
                  icon: Icon(
                    FontAwesomeIcons.building,
                    color: Colors.black38,
                  ),
                  hintText: 'Semarang',
                  labelText: 'Store City',
                  labelStyle: TextStyle(color: Colors.black54)),
              keyboardType: TextInputType.text,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                SizedBox(
                  width: 3.0,
                ),
                Text(
                  "Jenis\nToko",
                  style: TextStyle(fontSize: 12.0, color: Colors.black54),
                ),
                SizedBox(
                  width: 8.0,
                ),
                new DropdownButton<String>(
                  items: a.map((String value) {
                    return new DropdownMenuItem<String>(
                      value: value,
                      child: new Text(value),
                    );
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      jenismasihokeh = value;
                    });
                  },
                  value: jenismasihokeh,
                ),
              ],
            ),
          ),
          SizedBox(
            height: 10,
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
          Center(
            child: MaterialButton(
                color: Colors.blueGrey,
                child: Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: Text(
                    "Open a store!",
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                ),
                onPressed: () {
                  if (_image == null) {
                    Fluttertoast.showToast(msg: "Please choose an image.");
                  } else {
                    jadiToko();
                  }
                }),
          ),
          SizedBox(
            height: 5.0,
          )
        ],
      ),
    );
  }

  List<String> a = <String>[
    'Toko Serba Ada',
    'Rumah Makan',
    'Toko Buah',
    'Event',
    'Hotel',
    'Lainnya'
  ];
}
