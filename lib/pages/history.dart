import 'package:flutter/material.dart';
import 'package:masihokeh/main.dart';

class History extends StatefulWidget {
  final page;

  const History({Key key, this.page}) : super(key: key);

  @override
  HistoryState createState() => HistoryState();
}

class HistoryState extends State<History> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Application.router.pop(context);
          },
          icon: Icon(
            Icons.arrow_back,
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
      body: Column(
        children: <Widget>[
          Container(color: Colors.white, child: MyAppBar()),
          Expanded(child: Container(color: Colors.white, child: OderHistory2()))
        ],
      ),
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
              "Histori Order  ",
              style: TextStyle(fontSize: 25.0, fontFamily: "openbold"),
            ),
          ),
        ],
      ),
    );
  }
}

class OderHistory2 extends StatefulWidget {
  final String toolbarname;

  OderHistory2({Key key, this.toolbarname}) : super(key: key);

  @override
  State<StatefulWidget> createState() => Oderhistory2(toolbarname);
}

class Item {
  final String name;
  final String deliveryTime;
  final String oderId;
  final String oderAmount;
  final String paymentType;
  final String address;
  final String cancelOder;

  Item(
      {this.name,
      this.deliveryTime,
      this.oderId,
      this.oderAmount,
      this.paymentType,
      this.address,
      this.cancelOder});
}

class Oderhistory2 extends State<OderHistory2> {
  List list = ['12', '11'];
  bool checkboxValueA = true;
  bool checkboxValueB = false;
  bool checkboxValueC = false;
  // VoidCallback _showBottomSheetCallback;
  List<Item> itemList = <Item>[
    Item(
        name: 'Roti Keju',
        deliveryTime: '21.00-22.00',
        oderId: '#CN23656',
        oderAmount: 'Rp. 4000',
        paymentType: 'COD',
        address: 'Jl. Tirto Agung No.45, Boja Kab.Kendal',
        cancelOder: 'Cancel Order'),
    Item(
        name: 'Apel',
        deliveryTime: '22.01-24.00',
        oderId: '#CN33568',
        oderAmount: 'Rp. 40000',
        paymentType: 'COD',
        address: 'Jl. Bakso Goreng 41, Banyumanik, Kota Semarang',
        cancelOder: 'View Receipt'),
  ];

  // String toolbarname = 'Fruiys & Vegetables';
  // final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  String toolbarname;

  Oderhistory2(this.toolbarname);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: itemList.length,
        itemBuilder: (BuildContext cont, int ind) {
          return SafeArea(
              child: Column(children: <Widget>[
            Container(
                margin: EdgeInsets.only(left: 5.0, right: 5.0, bottom: 5.0),
                color: Colors.black12,
                child: Card(
                    elevation: 4.0,
                    child: Container(
                        padding:
                            const EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 10.0),
                        child: GestureDetector(
                            child: Column(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            // three line description
                            Container(
                              alignment: Alignment.topLeft,
                              child: Text(
                                itemList[ind].name,
                                style: TextStyle(
                                  fontSize: 16.0,
                                  fontStyle: FontStyle.normal,
                                  color: Colors.black87,
                                ),
                              ),
                            ),

                            Container(
                              margin: EdgeInsets.only(top: 3.0),
                            ),
                            Container(
                              alignment: Alignment.topLeft,
                              child: Text(
                                'Pickup Time : ' + itemList[ind].deliveryTime,
                                style: TextStyle(
                                    fontSize: 13.0, color: Colors.black54),
                              ),
                            ),
                            Divider(
                              height: 10.0,
                              color: Colors.amber.shade500,
                            ),

                            Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Container(
                                    padding: EdgeInsets.all(3.0),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: <Widget>[
                                        Text(
                                          'Order Id',
                                          style: TextStyle(
                                              fontSize: 13.0,
                                              color: Colors.black54),
                                        ),
                                        Container(
                                          margin: EdgeInsets.only(top: 3.0),
                                          child: Text(
                                            itemList[ind].oderId,
                                            style: TextStyle(
                                                fontSize: 15.0,
                                                color: Colors.black87),
                                          ),
                                        )
                                      ],
                                    )),
                                Container(
                                    padding: EdgeInsets.all(3.0),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: <Widget>[
                                        Text(
                                          'Price',
                                          style: TextStyle(
                                              fontSize: 13.0,
                                              color: Colors.black54),
                                        ),
                                        Container(
                                          margin: EdgeInsets.only(top: 3.0),
                                          child: Text(
                                            itemList[ind].oderAmount,
                                            style: TextStyle(
                                                fontSize: 15.0,
                                                color: Colors.black87),
                                          ),
                                        ),
                                      ],
                                    )),
                                Container(
                                    padding: EdgeInsets.all(3.0),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: <Widget>[
                                        Text(
                                          'Payment Type',
                                          style: TextStyle(
                                              fontSize: 13.0,
                                              color: Colors.black54),
                                        ),
                                        Container(
                                          margin: EdgeInsets.only(top: 3.0),
                                          child: Text(
                                            itemList[ind].paymentType,
                                            style: TextStyle(
                                                fontSize: 15.0,
                                                color: Colors.black87),
                                          ),
                                        )
                                      ],
                                    )),
                              ],
                            ),
                            Divider(
                              height: 10.0,
                              color: Colors.amber.shade500,
                            ),

                            Divider(
                              height: 10.0,
                              color: Colors.amber.shade500,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                Text(
                                  "Order Sukses",
                                  style: TextStyle(
                                      color: Colors.grey, fontSize: 28),
                                )
                              ],
                            )
                          ],
                        ))))),
          ]));
        });
  }
}
