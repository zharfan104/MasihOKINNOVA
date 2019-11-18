import 'package:auto_size_text/auto_size_text.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:masihokeh/main.dart';
import 'package:masihokeh/pages/chat/chat.dart';
import 'package:url_launcher/url_launcher.dart';

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
  int jumlah;
  String fotoproduk;
  String pembeliID;
  String produkID;
  int totalrate;
  double rating = 0.22;
  bool loading = false;
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  Future<void> jadimasihokeh() async {
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
    final QuerySnapshot result2 = await Firestore.instance
        .collection("masihokeh")
        .where("uid", isEqualTo: id.split("-")[1])
        .getDocuments();
    final List<DocumentSnapshot> documents = result.documents;
    final List<DocumentSnapshot> documents2 = result2.documents;

    deskripsi = documents[0]['deskripsi'] ?? "AS";
    hargasekarang = documents[0]['hargasekarang'] ?? "AS";
    hargaawal = documents[0]['hargaawal'] ?? "HAR";
    nama = documents[0]['nama'] ?? "NA";
    jamambil1 = documents[0]['waktuambil1'].substring(11, 16) ?? "JA";
    jamambil2 = documents[0]['waktuambil2'].substring(11, 16) ?? "JA";
    namaprodusen = documents[0]['namamasihokeh'] ?? "NAMAP";
    alamatmasihokeh = documents[0]['alamatmasihokeh'] ?? "ALA";
    photomasihokeh = documents[0]['photomasihokeh'] ?? "PT";
    uid = documents[0]['uid'] ?? "UID";
    jumlah = documents[0]['jumlah'] ?? 10;
    fotoproduk = documents[0]['photo'] ?? "FOTO";
    produkID = documents[0]['nama'] + "-" + documents[0]['uid'];
    totalrate = documents2[0]['totalrate'] ?? 1;
    rating = documents2[0]['rating'] ?? 5.0;
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
    final readButton = FloatingActionButton.extended(
      icon: Icon(
        Icons.shopping_basket,
        color: Colors.white,
      ),
      backgroundColor: Color.fromRGBO(58, 66, 86, 1.0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.00),
      ),
      onPressed: () {
        print(photomasihokeh);
        String fotodibalik = photomasihokeh.replaceAll("/", "garinggaring");
        fotodibalik = fotodibalik.replaceAll(":", "bagibagi");
        fotodibalik = fotodibalik.replaceAll("?", "tanyatanya");
        fotodibalik = fotodibalik.replaceAll("-", "dashdash");
        fotodibalik = fotodibalik.replaceAll("&", "dandan");

        Application.router.navigateTo(context,
            "/accorder?photomasihokeh=$fotodibalik&=$pembeliID&produkID=$produkID&harga=$hargasekarang&namaproduk=$nama&jamambil1=$jamambil1&jamambil2=$jamambil2&alamatmasihokeh=$alamatmasihokeh&namaprodusen=$namaprodusen");
      },
      label: Text(
        "Order This Food",
        style: TextStyle(color: Colors.white),
      ),
    );
    final bottomContent = Container(
      // height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      // color: Theme.of(context).primaryColor,
      padding: EdgeInsets.all(25.0),

      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            "Description",
            style: TextStyle(
                color: Colors.black, fontSize: 20.0, fontFamily: "openbold"),
          ),
          Text(
            deskripsi ?? "ayam",
            style: TextStyle(fontSize: 14.0, fontFamily: "openlight"),
          ),
        ],
      ),
    );

    final topContentText = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.max,
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
        Row(
          children: <Widget>[
            Icon(
              Icons.fastfood,
              color: Colors.white,
              size: 16.0,
            ),
            SizedBox(
              width: 10.0,
            ),
            Text(
              nama ?? "Nama",
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 16.0),
            ),
          ],
        ),

        Row(
          children: <Widget>[
            Icon(
              Icons.store,
              color: Colors.white,
              size: 16.0,
            ),
            SizedBox(
              width: 10.0,
            ),
            Text(
              "$namaprodusen" ?? "Produsen",
              style: TextStyle(
                color: Colors.white,
                fontSize: 14.0,
              ),
            ),
          ],
        ),
        Row(
          children: <Widget>[
            Icon(
              Icons.star,
              size: 15.0,
              color: Colors.amber,
            ),
            SizedBox(
              width: 10.0,
            ),
            Text(
              "${rating.toStringAsFixed(1)} ($totalrate)" ?? "Produsen",
              style: TextStyle(
                color: Colors.white,
                fontSize: 14.0,
              ),
            )
          ],
        ),
        Row(
          children: <Widget>[
            Icon(
              Icons.access_time,
              color: Colors.white,
              size: 16.0,
            ),
            SizedBox(
              width: 10.0,
            ),
            Text(
              "Today, $jamambil1 - $jamambil2" ?? "JamAmbil",
              style: TextStyle(color: Colors.white, fontSize: 14.0),
            ),
          ],
        ),
        Row(
          children: <Widget>[
            Icon(
              Icons.location_on,
              color: Colors.white,
              size: 16.0,
            ),
            SizedBox(
              width: 10.0,
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width - 80,
              height: 20.0,
              child: AutoSizeText(
                alamatmasihokeh ?? "Alamat",
                maxLines: 2,
                style: TextStyle(color: Colors.white, fontSize: 14.0),
              ),
            )
          ],
        ),
        Row(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(left: 4.0),
              child: Icon(
                FontAwesomeIcons.tag,
                color: Colors.white,
                size: 12.0,
              ),
            ),
            SizedBox(
              width: 10.0,
            ),
            new AutoSizeText(
              "Rp. $hargasekarang,-" ?? "Rp. 30000,-",
              style: TextStyle(color: Colors.white, fontSize: 16.0),
            ),
            SizedBox(
              width: 16.0,
            ),
            AutoSizeText(
              "Rp. $hargaawal,-" ?? "1000",
              style: TextStyle(
                  color: Colors.redAccent,
                  decoration: TextDecoration.lineThrough,
                  fontSize: 14.0),
            ),
          ],
        ),
        Row(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(left: 4.0),
              child: Icon(
                FontAwesomeIcons.infoCircle,
                color: Colors.white,
                size: 12.0,
              ),
            ),
            SizedBox(
              width: 10.0,
            ),
            new AutoSizeText(
              "$jumlah Remaining" ?? "0 Remaining",
              style: TextStyle(color: Colors.white, fontSize: 16.0),
            ),
          ],
        ),
        SizedBox(height: 12.0),
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Container(
                alignment: Alignment.center,
                child: FlatButton(
                  child: Row(
                    children: <Widget>[
                      Icon(
                        Icons.message,
                        color: Colors.white,
                      ),
                      SizedBox(
                        width: 10.0,
                      ),
                      Text(
                        "Chat Seller",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 12.0,
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  onPressed: () async {
                    List<dynamic> idbuyer = [pembeliID];
                    List<dynamic> idseller = [id.split("-")[1]];
                    await gotoChat(idbuyer, idseller);
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => Chat(
                                  peerId: id.split("-")[1],
                                  peerAvatar: photomasihokeh,
                                  nama: namaprodusen,
                                )));
                  },
                )),
            Container(
                alignment: Alignment.center,
                child: FlatButton(
                  child: Row(
                    children: <Widget>[
                      Icon(
                        Icons.phone,
                        color: Colors.white,
                      ),
                      SizedBox(
                        width: 10.0,
                      ),
                      Text(
                        "Call Seller",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 12.0,
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  onPressed: () async {
                    _launchCaller();
                  },
                )),
          ],
        ),
        // Row(
        //   children: <Widget>[
        //     SizedBox(
        //       width: 10.0,
        //     ),
        //     Icon(
        //       FontAwesomeIcons.infoCircle,
        //       color: Colors.white,
        //       size: 12.0,
        //     ),
        //     Text(
        //       " $jumlah  Tersisa" ?? "Tersisa",
        //       style: TextStyle(color: Colors.white, fontSize: 14.0),
        //     ),
        //     SizedBox(
        //       width: 90.0,
        //     ),
        //     beforePrice
        //   ],
        // )
      ],
    );
    final topContent = Stack(
      children: <Widget>[
        Container(
            padding: EdgeInsets.only(left: 10.0),
            height: MediaQuery.of(context).size.height * 0.6,
            decoration: new BoxDecoration(
              image: new DecorationImage(
                image: new NetworkImage(fotoproduk ??
                    "https://archive.org/download/no-photo-available/no-photo-available.png"),
                fit: BoxFit.cover,
              ),
            )),
        Container(
          height: MediaQuery.of(context).size.height * 0.6,
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
          floatingActionButton: readButton,
          body: ListView(
            children: <Widget>[topContent, bottomContent],
          ));
    } else {
      return Scaffold(
          body: Center(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation(Colors.grey),
                ),
              ),
              SizedBox(
                height: 10.0,
              ),
              Text(
                "Loading..",
                style: TextStyle(fontSize: 14.0),
              )
            ],
          ),
        ),
      ));
    }
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

_launchCaller() async {
  const url = "tel:08974744743";
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Could not launch $url';
  }
}
