/*
 * fluro
 * Created by Yakka
 * https://theyakka.com
 * 
 * Copyright (c) 2018 Yakka, LLC. All rights reserved.
 * See LICENSE for distribution and usage details.
 */
import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:masihokeh/route/route_handler.dart';

class Routes {
  static String landing = "/landing";
  static String details = "/details";
  static String kucing = "/kucing";
  static String reciept = "/reciepts";

  static void configureRoutes(Router router) {
    router.notFoundHandler = new Handler(
        handlerFunc: (BuildContext context, Map<String, List<String>> params) {
      print("ROUTE WAS NOT FOUND !!!");
    });

    router.define("/", handler: introHandler);
    router.define("/camera", handler: cameraHandler);
    router.define(landing, handler: landingHandler);
    router.define("/newmasihokeh", handler: newmasihokehHandler);

    router.define(details, handler: productDetailsHandler);
    router.define(kucing, handler: productDetailsHandler);
    router.define(reciept, handler: recieptsHandler);
    router.define("/account", handler: accountHandler);
    router.define("/dummy", handler: accountHandler);
    router.define("/setting", handler: settingHandler);
    router.define("/signup", handler: signupHandler);
    router.define("/login", handler: loginHandler);
    router.define("/instantsearch", handler: instantsearchHandler);
    router.define("/history", handler: orderhistoryHandler);
    router.define("/help", handler: helpHandler);
    router.define("/qrcode", handler: qrcodeHandler);
    router.define("/search", handler: searchHandler);
    router.define("/accorder", handler: acceptorderHandler);
    router.define("/store", handler: storeHandler);
    router.define("/history2", handler: historyHandler);
    router.define("/historypembeli", handler: historyPembeliHandler);

    router.define("/addproduk", handler: addProdukHandler);
    router.define("/orderin", handler: orderInHandler);
    router.define("/scanqr", handler: scanQRHandler);
    router.define("/mypoin/:email/:nama/:photourl/:poin", handler: poinHandler);

    router.define("/chat", handler: chatHandler);
  }
}
