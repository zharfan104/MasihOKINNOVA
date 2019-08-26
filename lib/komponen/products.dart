import 'package:flutter/material.dart';

class Products extends StatefulWidget {
  final Widget child;

  Products({Key key, this.child}) : super(key: key);

  _ProductsState createState() => _ProductsState();
}

class _ProductsState extends State<Products> {
  var productList = [
    {
      "name": "Susu 1",
      "picture":
          "https://waralabakan.com/media/k2/items/cache/9c2fe6cb8c357cf6d57c8926869c1003_XL.jpg",
      "olde_price": 120,
      "price": 85
    },
    {
      "name": "Susu 2",
      "picture":
          "https://waralabakan.com/media/k2/items/cache/9c2fe6cb8c357cf6d57c8926869c1003_XL.jpg",
      "olde_price": 120,
      "price": 100
    },
    {
      "name": "Susu 3",
      "picture":
          "https://waralabakan.com/media/k2/items/cache/9c2fe6cb8c357cf6d57c8926869c1003_XL.jpg",
      "olde_price": 120,
      "price": 50
    }
  ];
  @override
  Widget build(BuildContext context) {
    return GridView.builder(
        itemCount: productList.length,
        gridDelegate:
            new SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
        itemBuilder: (BuildContext context, int index) {
          return SingleProd(
            prodName: productList[index]['name'],
            prodPicture: productList[index]['picture'],
            prodOldPrice: productList[index]['old_price'],
            prodPrice: productList[index]['price'],
          );
        });
  }
}

class SingleProd extends StatelessWidget {
  final prodName;
  final prodPicture;
  final prodOldPrice;
  final prodPrice;

  SingleProd({
    this.prodName,
    this.prodPicture,
    this.prodOldPrice,
    this.prodPrice,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Hero(
          tag: prodName,
          child: Material(
            child: InkWell(
              onTap: () {},
              child: GridTile(
                  footer: Container(
                    color: Colors.white70,
                    child: ListTile(
                      leading: Text(
                        prodName,
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      title: Text(
                        "\$$prodPrice",
                        style: TextStyle(
                            color: Colors.red, fontWeight: FontWeight.w800),
                      ),
                      subtitle: Text(
                        "\$$prodOldPrice",
                        style: TextStyle(
                            color: Colors.black54,
                            fontWeight: FontWeight.w800,
                            decoration: TextDecoration.lineThrough),
                      ),
                    ),
                  ),
                  child: Image.network(
                    prodPicture,
                    fit: BoxFit.cover,
                  )),
            ),
          )),
    );
  }
}
