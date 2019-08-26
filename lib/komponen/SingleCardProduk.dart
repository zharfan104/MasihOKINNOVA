import 'package:flutter/material.dart';
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
              height: 120.0,
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
                    height: 50.0,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(2.0),
                      color: Theme.of(context).accentColor.withOpacity(0.75),
                    ),
                    child: ListTile(
                      leading: Text(
                        produk.nama,
                        style: TextStyle(
                            fontSize: 13.0,
                            fontFamily: "opensans",
                            fontWeight: FontWeight.w600,
                            color: Colors.white),
                      ),
                      title: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: <Widget>[
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
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
                                    "  ${produk.jam}",
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
                  left: 130.0,
                  bottom: 5.0,
                  child: Container(
                    decoration: new BoxDecoration(
                        borderRadius: BorderRadius.circular(100.0),
                        border:
                            Border.all(color: Colors.greenAccent, width: 0.0),
                        boxShadow: [
                          new BoxShadow(color: Colors.white, blurRadius: 2.0)
                        ]),
                    child: CircleAvatar(
                      backgroundColor: Colors.white,
                      radius: 40.0,
                      backgroundImage: NetworkImage(produk.heropicture),
                    ),
                  ),
                )
              ]))),
    );
  }
}
