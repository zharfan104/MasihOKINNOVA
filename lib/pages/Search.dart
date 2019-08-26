import 'package:flutter/material.dart';
import 'package:masihokeh/komponen/SingleCardProduk.dart';
import 'package:masihokeh/main.dart';
import 'package:masihokeh/models/ItemProduk.dart';

class Search extends StatefulWidget {
  final String query;

  const Search({Key key, this.query}) : super(key: key);
  @override
  _SearchState createState() => _SearchState(query);
}

List<Produk> buah = [
  Produk(
      id: "990",
      deskripsi:
          "Sed ut perspiciatis unde omnis iste natus error sit voluptatem accusantium doloremque laudantium, totam rem aperiam, eaque ipsa quae ab illo inventore veritatis et quasi architecto beatae vitae dicta sunt explicabo. Nemo enim ipsam voluptatem quia voluptas sit aspernatur aut odit aut fugit, sed quia consequuntur magni dolores eos qui ratione voluptatem sequi nesciunt. Neque porro quisquam est, qui dolorem ipsum quia dolor sit amet, consectetur, adipisci velit, sed quia non numquam eius modi tempora incidunt ut labore et dolore magnam aliquam quaerat voluptatem. Ut enim ad minima veniam, quis nostrum exercitationem ullam corporis suscipit laboriosam, nisi ut aliquid ex ea commodi consequatur? Quis autem vel eum iure reprehenderit qui in ea voluptate velit esse quam nihil molestiae consequatur, vel illum qui dolorem eum fugiat quo voluptas nulla pariatur?",
      jam: "15.00-22.00",
      sisa: "7",
      hargaAsal: "8000",
      hargaJadi: "3000",
      heropicture: "assets/logobuah.jpg",
      picture: "assets/pisang.jpg",
      nama: "Pisang",
      produsen: "Indomaret",
      alamat: "Tirtoagung 45"),
  Produk(
      id: "991",
      deskripsi:
          "Sed ut perspiciatis unde omnis iste natus error sit voluptatem accusantium doloremque laudantium, totam rem aperiam, eaque ipsa quae ab illo inventore veritatis et quasi architecto beatae vitae dicta sunt explicabo. Nemo enim ipsam voluptatem quia voluptas sit aspernatur aut odit aut fugit, sed quia consequuntur magni dolores eos qui ratione voluptatem sequi nesciunt. Neque porro quisquam est, qui dolorem ipsum quia dolor sit amet, consectetur, adipisci velit, sed quia non numquam eius modi tempora incidunt ut labore et dolore magnam aliquam quaerat voluptatem. Ut enim ad minima veniam, quis nostrum exercitationem ullam corporis suscipit laboriosam, nisi ut aliquid ex ea commodi consequatur? Quis autem vel eum iure reprehenderit qui in ea voluptate velit esse quam nihil molestiae consequatur, vel illum qui dolorem eum fugiat quo voluptas nulla pariatur?",
      jam: "16.00-22.00",
      sisa: "6",
      hargaAsal: "7000",
      hargaJadi: "3000",
      alamat: "Tirtoagung 45",
      heropicture: "assets/logobuah.jpg",
      picture: "assets/salak.jpg",
      nama: "Salak",
      produsen: "Indomaret"),
  Produk(
      id: "992",
      deskripsi:
          "Sed ut perspiciatis unde omnis iste natus error sit voluptatem accusantium doloremque laudantium, totam rem aperiam, eaque ipsa quae ab illo inventore veritatis et quasi architecto beatae vitae dicta sunt explicabo. Nemo enim ipsam voluptatem quia voluptas sit aspernatur aut odit aut fugit, sed quia consequuntur magni dolores eos qui ratione voluptatem sequi nesciunt. Neque porro quisquam est, qui dolorem ipsum quia dolor sit amet, consectetur, adipisci velit, sed quia non numquam eius modi tempora incidunt ut labore et dolore magnam aliquam quaerat voluptatem. Ut enim ad minima veniam, quis nostrum exercitationem ullam corporis suscipit laboriosam, nisi ut aliquid ex ea commodi consequatur? Quis autem vel eum iure reprehenderit qui in ea voluptate velit esse quam nihil molestiae consequatur, vel illum qui dolorem eum fugiat quo voluptas nulla pariatur?",
      jam: "13.00-22.00",
      sisa: "2",
      alamat: "Tirtoagung 45",
      hargaAsal: "7000",
      hargaJadi: "3000",
      heropicture: "assets/logobuah.jpg",
      picture: "assets/jambu.jpg",
      nama: "Jambu Biji",
      produsen: "Indomaret"),
  Produk(
      id: "993",
      deskripsi:
          "Sed ut perspiciatis unde omnis iste natus error sit voluptatem accusantium doloremque laudantium, totam rem aperiam, eaque ipsa quae ab illo inventore veritatis et quasi architecto beatae vitae dicta sunt explicabo. Nemo enim ipsam voluptatem quia voluptas sit aspernatur aut odit aut fugit, sed quia consequuntur magni dolores eos qui ratione voluptatem sequi nesciunt. Neque porro quisquam est, qui dolorem ipsum quia dolor sit amet, consectetur, adipisci velit, sed quia non numquam eius modi tempora incidunt ut labore et dolore magnam aliquam quaerat voluptatem. Ut enim ad minima veniam, quis nostrum exercitationem ullam corporis suscipit laboriosam, nisi ut aliquid ex ea commodi consequatur? Quis autem vel eum iure reprehenderit qui in ea voluptate velit esse quam nihil molestiae consequatur, vel illum qui dolorem eum fugiat quo voluptas nulla pariatur?",
      jam: "17.00-22.00",
      sisa: "3",
      alamat: "Tirtoagung 45",
      hargaAsal: "7000",
      hargaJadi: "3000",
      heropicture: "assets/logobuah.jpg",
      picture: "assets/apel.jpg",
      nama: "Apel Malang",
      produsen: "Indomaret"),
];

class _SearchState extends State<Search> {
  final String query;

  _SearchState(this.query);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            color: Colors.black,
            onPressed: () {
              Application.router.pop(context);
            },
          ),
          title: Text(
            query,
            style: TextStyle(color: Colors.black, fontFamily: "openbold"),
          ),
        ),
        body: ListView(
          children: <Widget>[
            SingleCardProduk(
              produk: buah[0],
            ),
            SingleCardProduk(
              produk: buah[1],
            ),
            SingleCardProduk(
              produk: buah[2],
            ),
            SingleCardProduk(
              produk: buah[3],
            )
          ],
        ));
  }
}
