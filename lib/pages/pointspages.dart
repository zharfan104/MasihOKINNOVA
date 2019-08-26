import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:masihokeh/main.dart';

var textYellow = Color(0xFFf6c24d);

class PointsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        leading: IconButton(
          color: Colors.black,
          onPressed: () {
            Application.router.pop(context);
          },
          icon: Icon(Icons.arrow_back),
        ),
        backgroundColor: Colors.white,
        centerTitle: true,
        title: Text(
          "My Points",
          style: TextStyle(
              color: Colors.black, fontFamily: "openbold", fontSize: 18.0),
        ),
      ),
      body: ListView(
        children: <Widget>[
          PoinKamu(),
          Padding(
            padding: const EdgeInsets.only(left: 20.0, top: 10.0, bottom: 10.0),
            child: Text(
              'Tukarkan Voucher!',
              style: TextStyle(
                  fontSize: 22.0,
                  color: Colors.black87,
                  fontWeight: FontWeight.bold),
            ),
          ),
          Divider(),
          SingleCardProduk(
            gambar: "assets/indomaret.jpg",
            tulisan1: "Indomaret Voucher!",
            tulisan2: "2 Gratis 1 Setiap Pembelian di Indomaret",
            points: "150",
          ),
          SingleCardProduk(
            gambar: "assets/pir.png",
            tulisan1: "Potongan Buah",
            tulisan2: "Potongan Rp.5.000 setiap pembelian buah",
            points: "200",
          )
        ],
      ),
    );
  }
}

class SingleCardProduk extends StatelessWidget {
  final String gambar;
  final String tulisan1;
  final String tulisan2;
  final String points;

  const SingleCardProduk(
      {Key key, this.gambar, this.tulisan1, this.tulisan2, this.points})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
              decoration:
                  BoxDecoration(borderRadius: BorderRadius.circular(10.0)),
              height: 160.0,
              child: Stack(children: <Widget>[
                Container(
                  height: 160.0,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage(gambar), fit: BoxFit.cover),
                      borderRadius: BorderRadius.circular(20.0),
                      gradient: LinearGradient(
                          colors: [Colors.black.withOpacity(0.1), Colors.black],
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter)),
                ),
                GridTile(
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.0),
                      gradient: LinearGradient(
                          colors: [Colors.black.withOpacity(0.1), Colors.black],
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter),
                    ),
                    height: 160.0,
                  ),
                  footer: Container(
                    height: 60.0,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5.0),
                      color: Theme.of(context).accentColor.withOpacity(0.30),
                    ),
                    child: ListTile(
                      leading: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            tulisan1,
                            style: TextStyle(
                                fontSize: 22.0,
                                fontFamily: "opensans",
                                fontWeight: FontWeight.w600,
                                color: textYellow),
                          ),
                          Text(
                            tulisan2,
                            style: TextStyle(
                                fontSize: 16.0,
                                fontFamily: "opensans",
                                fontWeight: FontWeight.w600,
                                color: Colors.white),
                          ),
                        ],
                      ),
                      title: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: <Widget>[
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[],
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                Positioned(
                  bottom: 8.0,
                  right: 8.0,
                  child: MaterialButton(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0)),
                    color: Theme.of(context).accentColor.withOpacity(0.75),
                    onPressed: () {},
                    child: Text(
                      "Tukarkan",
                      style: TextStyle(color: Colors.white, fontSize: 18.0),
                    ),
                  ),
                ),
                Positioned(
                  top: 2.0,
                  right: 2.0,
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Container(
                      height: 70.0,
                      width: 70.0,
                      decoration: BoxDecoration(
                        color: Theme.of(context).accentColor,
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: Colors.white,
                          style: BorderStyle.solid,
                        ),
                      ),
                      child: Center(
                          child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            "$points",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 16.0,
                                fontFamily: "openbold"),
                          ),
                          Icon(
                            FontAwesomeIcons.productHunt,
                            color: Colors.white,
                            size: 18.0,
                          )
                        ],
                      )),
                    ),
                  ),
                )
              ]))),
    );
  }
}

class ItemCard extends StatelessWidget {
  final String gambar;
  final String tulisan1;
  final String tulisan2;

  const ItemCard({Key key, this.gambar, this.tulisan1, this.tulisan2})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Container(
          height: 160.0,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
              image:
                  DecorationImage(image: AssetImage(gambar), fit: BoxFit.cover),
              borderRadius: BorderRadius.circular(20.0)),
          child: Stack(
            children: <Widget>[
              Container(
                height: 160.0,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20.0),
                    gradient: LinearGradient(
                        colors: [Colors.black.withOpacity(0.1), Colors.black],
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter)),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Spacer(),
                    Text(
                      tulisan1,
                      style: TextStyle(
                          color: textYellow,
                          fontWeight: FontWeight.bold,
                          fontSize: 24.0,
                          letterSpacing: 1.1),
                    ),
                    Text(
                      tulisan2,
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 16.0,
                          letterSpacing: 1.1),
                    ),
                  ],
                ),
              ),
            ],
          )),
    );
  }
}

class PoinKamu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        color: Theme.of(context).accentColor,
        child: Container(
            height: 100.0,
            alignment: Alignment.topLeft,
            margin: EdgeInsets.only(top: 7.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                new Row(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: CircleAvatar(
                          backgroundImage: NetworkImage(
                              "https://www.fakenamegenerator.com/images/sil-male.png")),
                    ),
                    SizedBox(
                      width: 10.0,
                    ),
                    new GestureDetector(
                      onTap: () {
                        /*Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => signup_screen()));*/
                      },
                      child: new Text(
                        "Zharfan Akbar A",
                        style: TextStyle(
                            fontSize: 22.0,
                            color: Colors.white,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    SizedBox(
                      width: 10.0,
                    ),
                    Expanded(child: Container()),
                    IconButton(
                      icon: Icon(Icons.settings),
                      onPressed: () {},
                    )
                  ],
                ),
                Row(
                  children: <Widget>[
                    SizedBox(
                      width: 65.0,
                    ),
                    Text(
                      'Poin Kamu : 311 ',
                      style: TextStyle(
                          fontSize: 18.0,
                          color: Colors.white,
                          fontWeight: FontWeight.normal),
                    ),
                    Icon(
                      FontAwesomeIcons.productHunt,
                      color: Colors.white,
                    )
                  ],
                ),
              ],
            )),
      ),
    );
  }
}
