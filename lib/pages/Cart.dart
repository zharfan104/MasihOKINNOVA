import 'package:flutter/material.dart';
import 'package:masihokeh/komponen/orderhistory_screen.dart';
import 'package:masihokeh/main.dart';
import 'package:fluro/fluro.dart';

class Cart extends StatefulWidget {
  final page;

  const Cart({Key key, this.page}) : super(key: key);

  @override
  _CartState createState() => _CartState();
}

class _CartState extends State<Cart> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        AppBar(
          leading: IconButton(
            onPressed: () {
              Scaffold.of(context).openDrawer();
            },
            icon: Icon(
              Icons.menu,
              color: Colors.black,
            ),
          ),
          backgroundColor: Colors.white,
          centerTitle: true,
          title: Text(
            "MasihOK",
            style: TextStyle(
                color: Colors.black, fontFamily: "pacifico", fontSize: 30.0),
          ),
        ),
        Container(color: Colors.white, child: MyAppBar()),
        Expanded(child: Container(color: Colors.white, child: OderHistory()))
      ],
    );
  }
}

class MyAppBar extends StatelessWidget {
  const MyAppBar({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          SizedBox(
            height: 25.0,
          ),
          Center(
            child: Text(
              "Your Order",
              style: TextStyle(fontSize: 25.0, fontFamily: "openbold"),
            ),
          ),
        ],
      ),
    );
  }
}

class SingleBukti extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Application.router.navigateTo(
          context,
          "/reciepts",
          transition: TransitionType.inFromLeft,
          transitionDuration: const Duration(milliseconds: 200),
        );
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
            decoration: BoxDecoration(
                border: Border.all(
                    color: Colors.grey, style: BorderStyle.solid, width: 3.0),
                borderRadius: BorderRadius.circular(10.0),
                color: Colors.grey),
            height: 150.0,
            width: MediaQuery.of(context).size.width,
            child: Container(
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey, width: 3.0),
                    borderRadius: BorderRadius.circular(10.0)),
                height: 200.0,
                child: Stack(children: <Widget>[
                  GridTile(
                    child: Container(
                      color: Colors.white,
                      height: 150.0,
                      child: Image.asset(
                        'assets/susu.jpg',
                        fit: BoxFit.cover,
                      ),
                    ),
                    footer: Container(
                      color: Colors.white,
                      child: ListTile(
                        leading: Text(
                          "Susuaa",
                          style: TextStyle(
                            fontSize: 25.0,
                          ),
                        ),
                        title: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: <Widget>[
                            Column(
                              children: <Widget>[
                                Text(
                                  "Rp. 3.000",
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 18.0,
                                  ),
                                ),
                                Text(
                                  "Rp. 7.000",
                                  style: TextStyle(
                                      color: Colors.grey,
                                      decoration: TextDecoration.lineThrough),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                      left: 170.0,
                      bottom: 1.0,
                      child: Hero(
                        tag: 'hero',
                        child: Container(
                          decoration: new BoxDecoration(
                              borderRadius: BorderRadius.circular(100.0),
                              border:
                                  Border.all(color: Colors.black, width: 4.0),
                              boxShadow: [
                                new BoxShadow(
                                    color: Colors.white, blurRadius: 20.0)
                              ]),
                          child: CircleAvatar(
                            backgroundColor: Colors.white,
                            radius: 35.0,
                            backgroundImage: AssetImage('assets/indomaret.jpg'),
                          ),
                        ),
                      ))
                ]))),
      ),
    );
  }
}

class SingleCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GridTile(
      header: Image.asset("assets/1.jpg"),
      child: Text("data"),
    );
  }
}
