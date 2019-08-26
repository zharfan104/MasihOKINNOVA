import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:masihokeh/komponen/AccOrder.dart';
import 'package:masihokeh/komponen/orderhistory_screen.dart';
import 'package:masihokeh/komponen/qrcode.dart';
import 'package:masihokeh/komponen/reciepts.dart';
import 'package:masihokeh/pages/Account_screen.dart';
import 'package:masihokeh/pages/PindaiQR.dart';
import 'package:masihokeh/pages/Search.dart';
import 'package:masihokeh/pages/addproduk.dart';
import 'package:masihokeh/pages/help_screen.dart';
import 'package:masihokeh/pages/history.dart';
import 'package:masihokeh/pages/instantsearch.dart';
import 'package:masihokeh/pages/intropages.dart';
import 'package:masihokeh/pages/landing_page.dart';
import 'package:masihokeh/pages/ProductPages.dart';
import 'package:masihokeh/pages/logind_signup.dart';
import 'package:masihokeh/pages/newtoko.dart';
import 'package:masihokeh/pages/orderin.dart';
import 'package:masihokeh/pages/pointspages.dart';
import 'package:masihokeh/pages/setting_screen.dart';
import 'package:masihokeh/pages/signup_screen.dart';
import 'package:masihokeh/pages/storepages.dart';

var recieptsHandler = Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> params) {
  return RecieptDetails();
});
var accountHandler = Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> params) {
  return AccountScreen();
});
var signupHandler = Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> params) {
  return SignupScreen();
});
var orderhistoryHandler = Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> params) {
  return OderHistory(
    toolbarname: "Halo",
  );
});
var qrcodeHandler = Handler(
    type: HandlerType.function,
    handlerFunc: (BuildContext context, Map<String, List<String>> params) {
      String orderID = params["orderID"]?.first ?? "asdasdasd";

      showDialog(
          context: context,
          builder: (context) {
            return new Qrcode(
              orderID: orderID,
            );
          });
    });
var acceptorderHandler = Handler(
    type: HandlerType.function,
    handlerFunc: (BuildContext context, Map<String, List<String>> params) {
      String produkID = params["produkID"]?.first ?? "as";
      String pembeliID = params["pembeliID"]?.first ?? "as";
      String harga = params["harga"]?.first ?? "as";
      String namaproduk = params["namaproduk"]?.first ?? "as";
      String jamambil1 = params["jamambil1"]?.first ?? "as";
      String jamambil2 = params["jamambil2"]?.first ?? "as";
      String alamatmasihokeh =
          params["alamatmasihokeh"]?.first ?? "ini alamatnya";
      print("di handler $alamatmasihokeh");
      print(params);
      print(params);
      showDialog(
          context: context,
          builder: (context) {
            return new Accorder(
              pembeliID: pembeliID,
              produkID: produkID,
              harga: harga,
              nama: namaproduk,
              jamambil1: jamambil1,
              jamambil2: jamambil2,
              alamat: alamatmasihokeh,
            );
          });
    });
var searchHandler = Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> params) {
  String query = params["query"]?.first;
  print(query);
  return Search(
    query: query,
  );
});
var helpHandler = Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> params) {
  return HelpScreen(
    toolbarname: "Halo",
  );
});
var loginHandler = Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> params) {
  return LoginScreen();
});
var settingHandler = Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> params) {
  return SettingScreen(
    toolbarname: "Halo",
  );
});
var newmasihokehHandler = Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> params) {
  return NewToko();
});
var introHandler = Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> params) {
  return MyApp();
});
var pointsHandler = Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> params) {
  return PointsPage();
});
var storeHandler = Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> params) {
  return StorePage();
});
var landingHandler = Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> params) {
  String nama = "FUCK";
  String email = "YOU";
  String photourl = "BANGSAT";

  return LandingPage(
    email: email,
    nama: nama,
    photourl: photourl,
  );
});
var productDetailsHandler = Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> params) {
  String id = params["id"]?.first;
  return ProductDetails(
    id: id,
  );
});
var historyHandler = Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> params) {
  return History();
});
var instantsearchHandler = Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> params) {
  return InstantSearch();
});
var scanQRHandler = Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> params) {
  return ScanQR();
});
var orderInHandler = Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> params) {
  return OrderIn();
});
var addProdukHandler = Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> params) {
  return AddProduk();
});

class Kucing extends StatelessWidget {
  final Widget child;

  Kucing({Key key, this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.black,
    );
  }
}
