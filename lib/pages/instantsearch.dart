import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:masihokeh/komponen/SingleCardProduk.dart';
import 'package:masihokeh/main.dart';
import 'package:masihokeh/models/ItemProduk.dart';
import 'package:masihokeh/pages/searchService.dart';

class InstantSearch extends StatefulWidget {
  @override
  _InstantSearchState createState() => new _InstantSearchState();
}

class _InstantSearchState extends State<InstantSearch> {
  var queryResultSet = [];
  var tempSearchStore = [];

  initiateSearch(value) {
    if (value.length == 0) {
      setState(() {
        queryResultSet = [];
        tempSearchStore = [];
      });
    }

    if (queryResultSet.length == 0 && value.length == 1) {
      SearchService().searchByName(value).then((QuerySnapshot docs) {
        for (int i = 0; i < docs.documents.length; ++i) {
          queryResultSet.add(docs.documents[i].data);
          print(queryResultSet);
        }
      });
    } else {
      tempSearchStore = [];
      queryResultSet.forEach((element) {
        setState(() {
          tempSearchStore.add(element);
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        body: Column(children: <Widget>[
      Padding(
        padding: const EdgeInsets.all(10.0),
        child: TextField(
          onChanged: (val) {
            initiateSearch(val);
          },
          decoration: InputDecoration(
              prefixIcon: IconButton(
                color: Colors.black,
                icon: Icon(Icons.arrow_back),
                iconSize: 20.0,
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              contentPadding: EdgeInsets.only(left: 25.0),
              hintText: 'Cari makanan...',
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(4.0))),
        ),
      ),
      SizedBox(height: 10.0),
      Expanded(
        child: ListView.builder(
            itemCount: tempSearchStore.length,
            itemBuilder: (BuildContext context, int index) {
              String url = tempSearchStore[index]["nama"] +
                  "-" +
                  tempSearchStore[index]["uid"];
              String nama = tempSearchStore[index]["nama"];

              String hargaawal = tempSearchStore[index]["hargaawal"] ?? "a";
              String hargasekarang =
                  tempSearchStore[index]["hargasekarang"] ?? "a";
              String waktuawal = tempSearchStore[index]["waktuambil1"] ?? "a";
              String waktusekarang =
                  tempSearchStore[index]["waktuambil2"] ?? "a";
              String deskripsiproduk =
                  tempSearchStore[index]["deskripsi"] ?? "a";
              String namamasihokeh =
                  tempSearchStore[index]["namamasihokeh"] ?? "a";
              String alamatmasihokeh = tempSearchStore[index]["alamat"] ?? "a";
              String photomasihokeh =
                  tempSearchStore[index]["photomasihokeh"] ?? "a";
              String sisa = tempSearchStore[index]["jumlah"] ?? 10;
              String photo = tempSearchStore[index]["photo"] ?? "a";
              if (tempSearchStore.length != 0) {
                return Hero(
                  tag: url,
                  child: SingleCardProduk(
                    nama: url,
                    produk: Produk(
                        nama: nama,
                        alamat: alamatmasihokeh,
                        hargaAsal: hargaawal,
                        hargaJadi: hargasekarang,
                        heropicture: photomasihokeh,
                        deskripsi: deskripsiproduk,
                        id: index.toString(),
                        jam: waktuawal.substring(11, 16),
                        picture: photo,
                        produsen: namamasihokeh,
                        sisa: sisa ?? 5),
                  ),
                );
              } else {
                return Center(
                  child: Text("Sorry, food not found."),
                );
              }
            }),
      )

      //  ListView.builder(
      //                     controller: scrollController,
      //                     itemCount: snapshot.data.documents.length,
      //                     itemBuilder: (BuildContext context, int index) {
      //                       return Hero(
      //                         tag: index,
      //                         child: SingleCardProduk(
      //                           nama: snapshot.data.documents[index]["nama"] +
      //                               "-" +
      //                               snapshot.data.documents[index]["uid"],
      //                           produk: Produk(
      //                               nama: snapshot.data.documents[index]
      //                                   ["nama"],
      //                               alamat: snapshot.data.documents[index]
      //                                   ["alamatmasihokeh"],
      //                               hargaAsal: snapshot.data.documents[index]
      //                                   ["hargaawal"],
      //                               hargaJadi: snapshot.data.documents[index]
      //                                   ["hargasekarang"],
      //                               heropicture: snapshot.data.documents[index]
      //                                   ["photomasihokeh"],
      //                               deskripsi: snapshot.data.documents[index]
      //                                   ["nama"],
      //                               id: index.toString(),
      //                               jam: snapshot
      //                                   .data.documents[index]["waktuambil2"]
      //                                   .substring(12, 16),
      //                               picture: snapshot.data.documents[index]
      //                                   ["photo"],
      //                               produsen: snapshot.data.documents[index]
      //                                   ["namamasihokeh"],
      //                               sisa: snapshot.data.documents[index]
      //                                       ["jumlah"] ??
      //                                   "5"),
      //                         ),
      //                       );
      //                     },
      //                   )
      // GridView.count(
      //     padding: EdgeInsets.only(left: 10.0, right: 10.0),
      //     crossAxisCount: 2,
      //     crossAxisSpacing: 4.0,
      //     mainAxisSpacing: 4.0,
      //     primary: false,
      //     shrinkWrap: true,
      //     children: tempSearchStore.map((element) {
      //       return buildResultCard(element);
      //     }).toList())
    ]));
  }
}

Widget buildResultCard(data) {
  return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
      elevation: 2.0,
      child: Container(
          child: Center(
              child: Text(
        data['nama'],
        textAlign: TextAlign.center,
        style: TextStyle(
          color: Colors.black,
          fontSize: 20.0,
        ),
      ))));
}
