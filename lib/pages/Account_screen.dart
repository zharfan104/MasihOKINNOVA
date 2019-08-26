import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:masihokeh/main.dart';

class AccountScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => Account();
}

class Account extends State<AccountScreen> {
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  String nama = 'RAMADHAN PRATAMA';
  String status = 'Pelanggan';
  String email = 'reix110199@gmail.com';
  String photoUrl;
  bool loading;

  @override
  void initState() {
    super.initState();
    cekUser();
  }

  Future cekUser() async {
    setState(() {
      loading = true;
    });

    final FirebaseUser user = await firebaseAuth.currentUser();
    if (user != null) {
      final QuerySnapshot result = await Firestore.instance
          .collection("users")
          .where("id", isEqualTo: user.uid)
          .getDocuments();
      final List<DocumentSnapshot> documents = result.documents;
      setState(() {
        nama = documents[0]['nama'];
        photoUrl = documents[0]['profilePicture'] ??
            "https://www.fakenamegenerator.com/images/sil-male.png";
        email = documents[0]['email'];
        if (documents[0]['masihokeh']) {
          status = "masihokeh";
        }
      });
      setState(() {
        loading = false;
      });
    } else {}
  }

  @override
  Widget build(BuildContext context) {
    Icon ofericon = new Icon(
      Icons.edit,
      color: Colors.black38,
    );
    Icon keyloch = new Icon(
      Icons.vpn_key,
      color: Colors.black38,
    );
    Icon clear = new Icon(
      Icons.history,
      color: Colors.black38,
    );
    Icon logout = new Icon(
      Icons.do_not_disturb_on,
      color: Colors.black38,
    );
    if (loading == true) {
      return Scaffold(
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Container(
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation(Colors.grey),
              ),
            ),
          ),
        ),
      );
    } else {
      return new Scaffold(
        appBar: new AppBar(
          backgroundColor: Colors.white,
          leading: IconButton(
            onPressed: () {
              Application.router.pop(context);
            },
            icon: Icon(
              Icons.arrow_back,
              color: Colors.black,
            ),
          ),
          title: Text(
            'My Account',
            style: TextStyle(color: Colors.black),
          ),
        ),
        body: SingleChildScrollView(
            child: new Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          textDirection: TextDirection.ltr,
          children: <Widget>[
            new Container(
              margin: EdgeInsets.all(7.0),
              alignment: Alignment.topCenter,
              height: 280.0,
              child: new Card(
                elevation: 3.0,
                child: Column(
                  children: <Widget>[
                    new Container(
                        alignment: Alignment.topCenter,
                        child: Container(
                          width: 100.0,
                          height: 100.0,
                          margin: const EdgeInsets.all(10.0),
                          // padding: const EdgeInsets.all(3.0),
                          child: ClipOval(
                            child: Image.network(photoUrl ??
                                'https://lh3.googleusercontent.com/-w3QCBzQqUCo/AAAAAAAAAAI/AAAAAAAAAAA/ACHi3rd9DwiLseAsOIfBpU8cKN85Ex_y8A/mo/photo.jpg'),
                          ),
                        )),

                    new FlatButton(
                      onPressed: null,
                      child: Text(
                        'Change',
                        style:
                            TextStyle(fontSize: 13.0, color: Colors.blueAccent),
                      ),
                      shape: RoundedRectangleBorder(
                          borderRadius: new BorderRadius.circular(30.0),
                          side: BorderSide(color: Colors.blueAccent)),
                    ),

                    new Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        new Container(
                          margin: EdgeInsets.only(
                              left: 10.0, top: 20.0, right: 5.0, bottom: 5.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: <Widget>[
                              new Text(
                                nama,
                                style: TextStyle(
                                  color: Colors.black87,
                                  fontSize: 15.0,
                                  fontWeight: FontWeight.bold,
                                  letterSpacing: 0.5,
                                ),
                              ),
                              _verticalDivider(),
                              new Text(
                                status,
                                style: TextStyle(
                                    color: Colors.black45,
                                    fontSize: 13.0,
                                    fontWeight: FontWeight.bold,
                                    letterSpacing: 0.5),
                              ),
                              _verticalDivider(),
                              new Text(
                                email,
                                style: TextStyle(
                                    color: Colors.black45,
                                    fontSize: 13.0,
                                    fontWeight: FontWeight.bold,
                                    letterSpacing: 0.5),
                              )
                            ],
                          ),
                        ),
                        new Container(
                          alignment: Alignment.centerLeft,
                          child: IconButton(
                              icon: ofericon,
                              color: Colors.blueAccent,
                              onPressed: null),
                        )
                      ],
                    ),
                    // VerticalDivider(),
                  ],
                ),
              ),
            ),
            new Container(
              margin: EdgeInsets.all(7.0),
              child: Card(
                elevation: 1.0,
                child: Row(
                  children: <Widget>[
                    new IconButton(icon: keyloch, onPressed: null),
                    _verticalD(),
                    new Text(
                      'Change Password',
                      style: TextStyle(fontSize: 15.0, color: Colors.black87),
                    )
                  ],
                ),
              ),
            ),
            new Container(
              margin: EdgeInsets.all(7.0),
              child: Card(
                elevation: 1.0,
                child: Row(
                  children: <Widget>[
                    new IconButton(icon: clear, onPressed: null),
                    _verticalD(),
                    new Text(
                      'Clear History',
                      style: TextStyle(
                        fontSize: 15.0,
                        color: Colors.black87,
                      ),
                    )
                  ],
                ),
              ),
            ),
            new Container(
              margin: EdgeInsets.all(7.0),
              child: Card(
                elevation: 1.0,
                child: Row(
                  children: <Widget>[
                    new IconButton(icon: logout, onPressed: null),
                    _verticalD(),
                    new Text(
                      'Deactivate Account',
                      style: TextStyle(
                        fontSize: 15.0,
                        color: Colors.redAccent,
                      ),
                    )
                  ],
                ),
              ),
            )
          ],
        )),
      );
    }
  }

  _verticalDivider() => Container(
        padding: EdgeInsets.all(2.0),
      );

  _verticalD() => Container(
        margin: EdgeInsets.only(left: 3.0, right: 0.0, top: 0.0, bottom: 0.0),
      );
}
