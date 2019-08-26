import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:masihokeh/main.dart';

class ProductDetails extends StatefulWidget {
  final String id;

  const ProductDetails({Key key, this.id}) : super(key: key);

  @override
  _ProductDetailsState createState() => _ProductDetailsState(id: id);
}

class _ProductDetailsState extends State<ProductDetails> {
  final String id;
  String deskripsi;
  String hargasekarang;
  String hargaawal;
  String nama;
  String jamambil1;
  String jamambil2;

  String namaprodusen;
  String alamatmasihokeh;
  String photomasihokeh;
  String uid;
  String jumlah;
  String fotoproduk;
  String pembeliID;
  String produkID;
  bool loading = false;
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  Future<void> jadimasihokeh() async {
    print(id);
    setState(() {
      loading = true;
    });
    final FirebaseUser user = await firebaseAuth.currentUser();
    pembeliID = user.uid;
    final QuerySnapshot result = await Firestore.instance
        .collection("produk")
        .where("nama", isEqualTo: id.split("-")[0])
        .where("uid", isEqualTo: id.split("-")[1])
        .getDocuments();
    final List<DocumentSnapshot> documents = result.documents;

    deskripsi = documents[0]['deskripsi'] ?? "AS";
    hargasekarang = documents[0]['hargasekarang'] ?? "AS";
    hargaawal = documents[0]['hargaawal'] ?? "HAR";
    nama = documents[0]['nama'] ?? "NA";
    jamambil1 = documents[0]['waktuambil1'].substring(12, 16) ?? "JA";
    jamambil2 = documents[0]['waktuambil2'].substring(12, 16) ?? "JA";
    namaprodusen = documents[0]['namamasihokeh'] ?? "NAMAP";
    alamatmasihokeh = documents[0]['alamatmasihokeh'] ?? "ALA";
    photomasihokeh = documents[0]['photomasihokeh'] ?? "PT";
    uid = documents[0]['uid'] ?? "UID";
    jumlah = documents[0]['jumlah'] ?? "JUM";
    fotoproduk = documents[0]['photo'] ?? "FOTO";
    produkID = documents[0]['nama'] + "-" + documents[0]['uid'];
    print(deskripsi + hargaawal + alamatmasihokeh + alamatmasihokeh);
    setState(() {
      loading = false;
    });
  }

  _ProductDetailsState({this.id});
  @override
  void initState() {
    super.initState();
    jadimasihokeh();
  }

  @override
  Widget build(BuildContext context) {
    final readButton = Padding(
        padding: EdgeInsets.symmetric(vertical: 16.0),
        child: Center(
          child: RaisedButton(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20.00),
            ),
            onPressed: () => {
              Application.router.navigateTo(context,
                  "/accorder?pembeliID=$pembeliID&produkID=$produkID&harga=$hargasekarang&namaproduk=$nama&jamambil1=$jamambil1&jamambil2=$jamambil2&alamatmasihokeh=$alamatmasihokeh")
            },
            color: Color.fromRGBO(58, 66, 86, 1.0),
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Text("Beli Makanan Ini",
                  style: TextStyle(color: Colors.white, fontFamily: "roboto")),
            ),
          ),
        ));
    final bottomContent = Container(
      // height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      // color: Theme.of(context).primaryColor,
      padding: EdgeInsets.all(40.0),

      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            "Deskripsi",
            style: TextStyle(
                color: Colors.black, fontSize: 18.0, fontFamily: "openbold"),
          ),
          Text(
            deskripsi ?? "ayam",
            style: TextStyle(fontSize: 18.0, fontFamily: "openlight"),
          ),
          Center(child: readButton)
        ],
      ),
    );

    final coursePrice = Container(
      padding: const EdgeInsets.all(2.0),
      decoration: new BoxDecoration(
          border: new Border.all(color: Colors.white),
          borderRadius: BorderRadius.circular(5.0)),
      child: new Text(
        hargasekarang ?? "5000",
        style: TextStyle(color: Colors.white, fontSize: 14.0),
      ),
    );
    final beforePrice = Container(
      padding: const EdgeInsets.all(5.0),
      child: new Text(
        hargaawal ?? "1000",
        style: TextStyle(
            color: Colors.redAccent,
            decoration: TextDecoration.lineThrough,
            fontSize: 12.0),
      ),
    );
    final topContentText = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        SizedBox(height: 40.0),
        CircleAvatar(
          radius: 30.0,
          backgroundImage: NetworkImage(photomasihokeh ??
              "https://firebasestorage.googleapis.com/v0/b/masihok-ea318.appspot.com/o/yBAPX768fbODriCHdXk2gE3BIy52%2FLogo.jpg?alt=media&token=cd643b09-26ad-4e9c-955c-0f94e2a570aa"),
        ),
        Container(
          width: 90.0,
          child: new Divider(color: Colors.green),
        ),
        SizedBox(height: 10.0),
        Text(
          nama ?? "Nama",
          style: TextStyle(color: Colors.white, fontSize: 20.0),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Expanded(
                flex: 4,
                child: Padding(
                    padding: EdgeInsets.only(left: 10.0),
                    child: Text(
                      namaprodusen ?? "Produsen",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 12.0,
                          fontWeight: FontWeight.bold),
                    ))),
          ],
        ),
        Row(
          children: <Widget>[
            SizedBox(
              width: 10.0,
            ),
            Icon(
              Icons.access_time,
              color: Colors.white,
              size: 12.0,
            ),
            Text(
              "$jamambil1 - $jamambil2" ?? "JamAmbil",
              style: TextStyle(color: Colors.white, fontSize: 14.0),
            ),
          ],
        ),
        Row(
          children: <Widget>[
            SizedBox(
              width: 10.0,
            ),
            Icon(
              FontAwesomeIcons.mapMarkerAlt,
              color: Colors.white,
              size: 12.0,
            ),
            Text(
              alamatmasihokeh ?? "Alamat",
              style: TextStyle(color: Colors.white, fontSize: 14.0),
            ),
            SizedBox(
              width: 60.0,
            ),
            coursePrice
          ],
        ),
        Row(
          children: <Widget>[
            SizedBox(
              width: 10.0,
            ),
            Icon(
              FontAwesomeIcons.infoCircle,
              color: Colors.white,
              size: 12.0,
            ),
            Text(
              " $jumlah  Tersisa" ?? "Terssa",
              style: TextStyle(color: Colors.white, fontSize: 14.0),
            ),
            SizedBox(
              width: 90.0,
            ),
            beforePrice
          ],
        )
      ],
    );
    final topContent = Stack(
      children: <Widget>[
        Container(
            padding: EdgeInsets.only(left: 10.0),
            height: MediaQuery.of(context).size.height * 0.5,
            decoration: new BoxDecoration(
              image: new DecorationImage(
                image: new NetworkImage(fotoproduk ??
                    "https://www.youtube.comhttps://firebasestorage.googleapis.com/v0/b/masihok-ea318.appspot.com/o/yBAPX768fbODriCHdXk2gE3BIy52%2FLogo.jpg?alt=media&token=cd643b09-26ad-4e9c-955c-0f94e2a570aa/watch?v=3ZDYxgKjEs8"),
                fit: BoxFit.cover,
              ),
            )),
        Container(
          height: MediaQuery.of(context).size.height * 0.5,
          padding: EdgeInsets.fromLTRB(30.0, 30.0, 0.0, 30.0),
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(color: Color.fromRGBO(58, 66, 86, .9)),
          child: Center(
            child: topContentText,
          ),
        ),
        Positioned(
          left: 8.0,
          top: 40.0,
          child: InkWell(
            onTap: () {
              Application.router.pop(context);
            },
            child: Icon(Icons.arrow_back, color: Colors.white),
          ),
        )
      ],
    );
    if (loading == false) {
      return Scaffold(
          body: ListView(
        children: <Widget>[topContent, bottomContent],
      ));
    } else {
      return Scaffold(
        body: Center(
          child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Row(
                children: <Widget>[
                  Container(
                    child: CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation(Colors.grey),
                    ),
                  ),
                  Text(id.split("-")[0] ?? "a"),
                  SizedBox(
                    width: 10.0,
                  ),
                  Text(id.split("-")[1] ?? "a"),
                ],
              )),
        ),
      );
    }
  }
}
