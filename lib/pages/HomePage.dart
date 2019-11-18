import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:masihokeh/komponen/SingleCardProduk.dart';
import 'package:masihokeh/models/ItemProduk.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';

typedef double GetOffsetMethod();
typedef void SetOffsetMethod(double offset);

class StatefulListView extends StatefulWidget {
  StatefulListView({Key key, this.getOffsetMethod, this.setOffsetMethod})
      : super(key: key);

  final GetOffsetMethod getOffsetMethod;
  final SetOffsetMethod setOffsetMethod;

  @override
  _StatefulListViewState createState() => new _StatefulListViewState();
}

enum Answers { Semarang, Jakarta, Yogyakarta }

class _StatefulListViewState extends State<StatefulListView> {
  ScrollController scrollController;
  var list;
  var random;
  int gonta = 0;
  String _value = 'Semarang';
  void _setValue(String value) => setState(() => _value = value);

  Future _askUser() async {
    switch (await showDialog(
        context: context,
        /*it shows a popup with few options which you can select, for option we
        will wait for the user to select the option which it can use with switch cases*/
        child: new SimpleDialog(
          title: new Text(
            'Lokasi',
            style: TextStyle(
              fontSize: 30.0,
              fontWeight: FontWeight.bold,
              fontFamily: "Roboto",
            ),
          ),
          children: <Widget>[
            new SimpleDialogOption(
              child: new Text('Semarang',
                  style: TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                      fontFamily: "Roboto")),
              onPressed: () {
                Navigator.pop(context, Answers.Semarang);
              },
            ),
            new SimpleDialogOption(
              child: new Text('Jakarta',
                  style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                    fontFamily: "Roboto",
                  )),
              onPressed: () {
                Navigator.pop(context, Answers.Jakarta);
              },
            ),
            new SimpleDialogOption(
              child: new Text('Yogyakarta',
                  style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                    fontFamily: "Roboto",
                  )),
              onPressed: () {
                Navigator.pop(context, Answers.Yogyakarta);
              },
            ),
          ],
        ))) {
      case Answers.Semarang:
        _setValue('Semarang');
        break;
      case Answers.Jakarta:
        _setValue('Jakarta');
        break;
      case Answers.Yogyakarta:
        _setValue('Yogyakarta');
        break;
    }
  }

  var refreshKey = GlobalKey<RefreshIndicatorState>();

  @override
  void initState() {
    super.initState();
    refreshList();
    scrollController =
        new ScrollController(initialScrollOffset: widget.getOffsetMethod());
  }

  Produk a = Produk(
      id: "7",
      deskripsi:
          "Sed ut perspiciatis unde omnis iste natus error sit voluptatem accusantium doloremque laudantium, totam rem aperiam, eaque ipsa quae ab illo inventore veritatis et quasi architecto beatae vitae dicta sunt explicabo. Nemo enim ipsam voluptatem quia voluptas sit aspernatur aut odit aut fugit, sed quia consequuntur magni dolores eos qui ratione voluptatem sequi nesciunt. Neque porro quisquam est, qui dolorem ipsum quia dolor sit amet, consectetur, adipisci velit, sed quia non numquam eius modi tempora incidunt ut labore et dolore magnam aliquam quaerat voluptatem. Ut enim ad minima veniam, quis nostrum exercitationem ullam corporis suscipit laboriosam, nisi ut aliquid ex ea commodi consequatur? Quis autem vel eum iure reprehenderit qui in ea voluptate velit esse quam nihil molestiae consequatur, vel illum qui dolorem eum fugiat quo voluptas nulla pariatur?",
      jam: "21.00-22.00",
      sisa: 3,
      hargaAsal: "7000",
      hargaJadi: "3000",
      heropicture: "assets/indomaret.jpg",
      picture: "assets/tango.jpg",
      nama: "Tango",
      produsen: "Indomaret");
  Future<Null> refreshList() async {
    refreshList();
    return null;
  }
  @override
  void dispose() {
    super.dispose();
    //this method not called when user press android back button or quit
  }
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
     
        Container(
          width: MediaQuery.of(context).size.width,
          color: Colors.white,
          child: Center(
            child: Text(
              "Your Nearby Food!",
              style: TextStyle(
                  color: Colors.black, fontFamily: "openbold", fontSize: 20.0),
            ),
          ),
        ),
        Expanded(
          child: Container(
            color: Colors.white,
            child: StreamBuilder(
                stream: Firestore.instance
                    .collection("produk")
                    .where("kota", isEqualTo: _value)
                    .snapshots(),
                builder: (context, snapshot) {
                  if(snapshot.hasData){
                  if (snapshot.data.documents.length != 0) {
                    return LiquidPullToRefresh(
                        color: Colors.white,
                        backgroundColor: Theme.of(context).accentColor,
                        borderWidth: 3.0,
                        showChildOpacityTransition: false,
                        onRefresh: refreshList,
                        child: new ListView.builder(
                          controller: scrollController,
                          itemCount: snapshot.data.documents.length,
                          itemBuilder: (BuildContext context, int index) {
                            print(index);
                            return StreamBuilder(
     stream: Firestore.instance
                    .collection("masihokeh")
                    .where("uid", isEqualTo: snapshot.data.documents[index]["uid"] ?? "")
                    .snapshots(),                             
                     builder: (context, snapshot2) {
                   
                                return Hero(
                                  tag: index,
                                  child: SingleCardProduk(
                                    nama: snapshot.data.documents[index]["nama"] +
                                        "-" +
                                        snapshot.data.documents[index]["uid"],
                                    produk: Produk(
                                        nama: snapshot.data.documents[index]
                                            ["nama"],
                                        alamat: snapshot.data.documents[index]
                                            ["alamatmasihokeh"],
                                        hargaAsal: snapshot.data.documents[index]
                                            ["hargaawal"],
                                        hargaJadi: snapshot.data.documents[index]
                                            ["hargasekarang"],
                                        heropicture: snapshot.data.documents[index]
                                            ["photomasihokeh"],
                                        deskripsi: snapshot.data.documents[index]
                                            ["nama"],
                                        id: index.toString(),
                                        jam:  snapshot
                                            .data.documents[index]["waktuambil1"]
                                            .substring(11, 16)+ " - " +snapshot
                                            .data.documents[index]["waktuambil2"]
                                            .substring(11, 16),
                                        picture: snapshot.data.documents[index]
                                            ["photo"],
                                        produsen: snapshot.data.documents[index]
                                            ["namamasihokeh"],
                                          rating: snapshot2.hasData ? snapshot2.data.documents[0]
                                            ["rating"] ?? 5.0 : 5.0,
                                            totalrate: snapshot2.hasData ? snapshot2.data.documents[0]
                                            ["totalrate"] ?? 1 : 1,
                                            
                                        sisa: snapshot.data.documents[index]
                                                ["jumlah"] ??
                                            5),
                                  ),
                                );
                              }
                            );
                          },
                        ));
                  } else {
                    return Center(
                      child: Text("This city doesnt have any products"),
                    );
                  }
                }                   
                 return Center(child: CircularProgressIndicator());

                }
                ),
          ),
        )
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
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Text(
            "Makanan Terdekatmu!",
            style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
          ),
          Expanded(
            child: Container(),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              Text(
                'Lokasi',
                style: TextStyle(color: Colors.black54),
              ),
              InkWell(
                borderRadius: BorderRadius.circular(20.0),
                splashColor: Colors.grey,
                highlightColor: Colors.green,
                onTap: () {},
                child: Container(
                  decoration:
                      BoxDecoration(borderRadius: BorderRadius.circular(10.0)),
                  child: Text(
                    'Tembalang, Semarang',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
