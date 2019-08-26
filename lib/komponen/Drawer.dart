import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:masihokeh/main.dart';
import 'package:fluro/fluro.dart';
import 'package:masihokeh/pages/logind_signup.dart';

class DrawerKu extends StatefulWidget {
  @override
  _DrawerKuState createState() => _DrawerKuState();
}

class _DrawerKuState extends State<DrawerKu> {
  String email;
  String photourl;
  String nama;
  @override
  void initState() {
    super.initState();
    getemail();
  }

  getemail() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      email = prefs.getString('email') ?? 'a@gmail.com';
      nama = prefs.getString('nama') ?? 'a@gmail.com';
      photourl = prefs.getString('photourl') ?? 'a@gmail.com';
    });
    print(email + nama + photourl);
  }

  Widget build(BuildContext context) {
    return new Drawer(
      child: Container(
        width: 200.0,
        child: new ListView(
          children: <Widget>[
            Hero(
              tag: 'Akun',
              child: InkWell(
                onTap: () {
                  Application.router.navigateTo(context, "/account");
                },
                child: new Card(
                  child: UserAccountsDrawerHeader(
                    accountName: new Text(nama),
                    accountEmail: new Text(email),
                    decoration: new BoxDecoration(
                      backgroundBlendMode: BlendMode.difference,
                      color: Colors.white30,

                      /* image: new DecorationImage(
                     //   image: new ExactAssetImage('assets/images/lake.jpeg'),
                        fit: BoxFit.cover,
                      ),*/
                    ),
                    currentAccountPicture:
                        CircleAvatar(backgroundImage: NetworkImage(photourl)),
                  ),
                ),
              ),
            ),
            new Card(
              elevation: 4.0,
              child: new Column(
                children: <Widget>[
                  Hero(
                    tag: "My Points",
                    transitionOnUserGestures: true,
                    child: new ListTile(
                        leading: Icon(FontAwesomeIcons.star),
                        title: new Text("My Points"),
                        onTap: () {
                          Application.router.navigateTo(context, "/points",
                              transition: TransitionType.fadeIn);
                        }),
                  ),
                  new Divider(),
                  new Card(
                    elevation: 4.0,
                    child: new Column(
                      children: <Widget>[
                        Hero(
                          tag: "My Store",
                          transitionOnUserGestures: true,
                          child: new ListTile(
                              leading: Icon(FontAwesomeIcons.store),
                              title: new Text("My Store"),
                              onTap: () {
                                Application.router.navigateTo(context, "/store",
                                    transition: TransitionType.fadeIn);
                              }),
                        ),
                        new Divider(),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Card(
              elevation: 4.0,
              child: new Column(
                children: <Widget>[
                  Hero(
                    tag: "Setting",
                    child: new ListTile(
                      leading: Icon(Icons.settings),
                      title: new Text("Setting"),
                      onTap: () {
                        Application.router.navigateTo(context, "/setting",
                            transition: TransitionType.fadeIn);
                      },
                    ),
                  ),
                  new Divider(),
                  Hero(
                    tag: "login",
                    child: new ListTile(
                        leading: Icon(Icons.help),
                        title: new Text("Help"),
                        onTap: () {
                          Application.router.navigateTo(context, "/help",
                              transition: TransitionType.fadeIn);
                        }),
                  ),
                ],
              ),
            ),
            Hero(
              tag: "logout",
              child: new Card(
                elevation: 4.0,
                child: new ListTile(
                    leading: Icon(Icons.power_settings_new),
                    title: new Text(
                      "Logout",
                      style: new TextStyle(
                          color: Colors.redAccent, fontSize: 17.0),
                    ),
                    onTap: () {
                      final GoogleSignIn googleSignIn = GoogleSignIn();
                      googleSignIn.signOut();
                      Navigator.of(context).pushReplacement(
                          new MaterialPageRoute(
                              builder: (BuildContext context) =>
                                  LoginScreen()));
                    }),
              ),
            )
          ],
        ),
      ),
    );
  }
}
