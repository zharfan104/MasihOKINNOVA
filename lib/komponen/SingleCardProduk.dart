import 'package:auto_size_text/auto_size_text.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:masihokeh/main.dart';
import 'package:masihokeh/models/ItemProduk.dart';
import 'package:fluro/fluro.dart';

class SingleCardProduk extends StatelessWidget {
  final Produk produk;
  final String nama;

  const SingleCardProduk({Key key, this.produk, this.nama}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Application.router.navigateTo(context, "/details?id=$nama",
            transition: TransitionType.fadeIn);
      },
      child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
              decoration:
                  BoxDecoration(borderRadius: BorderRadius.circular(10.0)),
              height: 160.0,
              child: Stack(children: <Widget>[
                GridTile(
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.0),
                      image: DecorationImage(
                          image: NetworkImage(produk.picture),
                          fit: BoxFit.cover),
                      gradient: LinearGradient(
                          colors: [Colors.black.withOpacity(0.1), Colors.black],
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter),
                    ),
                    height: 130.0,
                  ),
                  footer: Container(
                    height: 60.0,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(2.0),
                      color: Theme.of(context).accentColor.withOpacity(0.90),
                    ),
                    child: ListTile(
                      leading: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              Container(
                                width: 155.0,
                                child: AutoSizeText(
                                  produk.produsen,
                                  minFontSize: 14.0,
                                  maxFontSize: 18.0,
                                  style: TextStyle(
                                      fontFamily: "opensans",
                                      fontWeight: FontWeight.w600,
                                      color: Colors.white),
                                ),
                              ),
                            ],
                          ),
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.only(right: 1.0),
                                child: Icon(
                                  Icons.star,
                                  size: 15.0,
                                  color: Colors.amber,
                                ),
                              ),
                              Text(
                                "${produk.rating.toStringAsFixed(1)} (${produk.totalrate})" ??
                                    "null",
                                style: TextStyle(
                                    fontSize: 13.0,
                                    fontFamily: "opensans",
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white),
                              ),
                            ],
                          )
                        ],
                      ),
                      title: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: <Widget>[
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Row(
                                children: <Widget>[
                                  Icon(
                                    Icons.access_time,
                                    color: Colors.white,
                                    size: 18.0,
                                  ),
                                  Text(
                                    " Today,${produk.jam}",
                                    style: TextStyle(
                                      fontFamily: "bold",
                                      color: Colors.white,
                                      fontSize: 13.0,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 4.0,
                              ),
                              Row(
                                children: <Widget>[
                                  Icon(Icons.info,
                                      color: Colors.white, size: 18.0),
                                  Text(
                                    "  ${produk.sisa.toString()} Remaining",
                                    style: TextStyle(
                                        fontSize: 13,
                                        color: Colors.white,
                                        fontFamily: "bold"),
                                  ),
                                ],
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                Positioned(
                  left: 0.0,
                  top: 10.0,
                  child: Container(
                    // margin: const EdgeInsets.all(15.0),
                    padding: const EdgeInsets.all(3.0),
                    decoration: BoxDecoration(
                      color: Colors.black54,
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(right: 6.0),
                          child: Icon(
                            FontAwesomeIcons.utensils,
                            size: 15.0,
                            color: Colors.white,
                          ),
                        ),
                        Text(
                          produk.nama,
                          style: TextStyle(
                              fontSize: 15.0,
                              fontFamily: "opensans",
                              fontWeight: FontWeight.w600,
                              color: Colors.white),
                        ),
                      ],
                    ),
                  ),
                ),
                Positioned(
                  left: 110.0,
                  bottom: 32.0,
                  child: Container(
                    decoration: new BoxDecoration(
                        borderRadius: BorderRadius.circular(120.0),
                        border:
                            Border.all(color: Colors.greenAccent, width: 0.2),
                        boxShadow: [
                          new BoxShadow(color: Colors.white, blurRadius: 2.0)
                        ]),
                    child: CircleAvatar(
                      backgroundColor: Colors.white,
                      radius: 40.0,
                      backgroundImage: NetworkImage(produk.heropicture),
                    ),
                  ),
                ),
              ]))),
    );
  }
}
