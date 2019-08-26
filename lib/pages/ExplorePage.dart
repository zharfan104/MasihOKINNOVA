import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:polygon_clipper/polygon_clipper.dart';
import 'package:masihokeh/main.dart';
import 'package:fluro/fluro.dart';

// IMAGES
var meatImage =
    'https://images.unsplash.com/photo-1532597311687-5c2dc87fff52?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1350&q=80';
var foodImage =
    'https://images.unsplash.com/photo-1520218508822-998633d997e6?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=634&q=80';

var burgerImage =
    'https://images.unsplash.com/photo-1534790566855-4cb788d389ec?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1350&q=80';
var chickenImage =
    'https://images.unsplash.com/photo-1532550907401-a500c9a57435?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1350&q=80';

// COLORS
var textYellow = Color(0xFFf6c24d);
var iconYellow = Color(0xFFf4bf47);

var green = Color(0xFF4caf6a);
var greenLight = Color(0xFFd8ebde);

var red = Color(0xFFf36169);
var redLight = Color(0xFFf2dcdf);

var blue = Color(0xFF398bcf);
var blueLight = Color(0xFFc1dbee);

class ExplorePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
        color: Colors.white,
        child: ListView(
          children: <Widget>[
            SizedBox(height: 20.0),
            MyAppBar(),
            SizedBox(height: 16.0),
            FoodListview(),
            SizedBox(height: 16.0),
            SelectTypeSection(),
            SizedBox(height: 16.0),
          ],
        ));
  }
}

class MyAppbar extends StatelessWidget {
  const MyAppbar({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      child: Container(
        height: 200.0,
        child: Padding(
          padding: const EdgeInsets.only(top: 8.0),
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: <Widget>[
              Column(
                children: <Widget>[
                  Icon(Icons.home),
                  Text('Home', style: TextStyle(fontSize: 12.0))
                ],
              ),
              Column(
                children: <Widget>[
                  Icon(Icons.home),
                  Text('Home', style: TextStyle(fontSize: 12.0))
                ],
              ),
              Column(
                children: <Widget>[
                  Icon(Icons.search, color: Colors.black45),
                  Text('Search', style: TextStyle(fontSize: 12.0))
                ],
              ),
              Container(
                width: 100.0,
              ),
              Column(
                children: <Widget>[
                  Icon(Icons.shop, color: Colors.black45),
                  Text(
                    'Wishlist',
                    style: TextStyle(fontSize: 12.0),
                  )
                ],
              ),
              Column(
                children: <Widget>[
                  Icon(
                    Icons.shopping_cart,
                    color: Colors.black45,
                  ),
                  Text('Cart', style: TextStyle(fontSize: 12.0))
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class MyActionButton extends StatelessWidget {
  const MyActionButton({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100.0,
      width: 100.0,
      child: ClipPolygon(
        sides: 6,
        child: Container(
          color: iconYellow,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Icon(FontAwesomeIcons.book),
              SizedBox(
                height: 4.0,
              ),
              Text(
                'Menu',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class SelectTypeSection extends StatelessWidget {
  const SelectTypeSection({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 92.0,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: ListView(
          scrollDirection: Axis.horizontal,
          children: <Widget>[
            Category(
              iconData: FontAwesomeIcons.appleAlt,
              nama: "Buah-buahan",
              warnaback: greenLight,
              warnaicon: green,
            ),
            SizedBox(
              width: 12.0,
            ),
            Category(
              iconData: FontAwesomeIcons.cookieBite,
              nama: "Snack",
              warnaback: redLight,
              warnaicon: red,
            ),
            SizedBox(
              width: 12.0,
            ),
            Category(
              iconData: FontAwesomeIcons.utensils,
              nama: "Makan Berat",
              warnaback: blueLight,
              warnaicon: blue,
            ),
            SizedBox(
              width: 12.0,
            ),
            Container(
              height: 92.0,
              width: 124.0,
              decoration: BoxDecoration(
                  color: blueLight, borderRadius: BorderRadius.circular(10.0)),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Icon(
                    FontAwesomeIcons.glassCheers,
                    color: blue,
                  ),
                  SizedBox(
                    height: 4.0,
                  ),
                  Text(
                    'Minuman',
                    style: TextStyle(color: blue, fontWeight: FontWeight.w500),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class FoodListview extends StatelessWidget {
  const FoodListview({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 8.0),
      child: Container(
        height: 160.0,
        child: ListView(
          scrollDirection: Axis.horizontal,
          children: <Widget>[
            ItemCard(
              gambar: "assets/pisang.jpg",
              tulisan1: "Diskon 50%",
              tulisan2: "Untuk Tiap Pembelian Lebih dari 3",
            ),
            ItemCard(
              gambar: "assets/roti.jpg",
              tulisan1: "Beli 2 gratis 1",
              tulisan2: "Untuk Tiap Pembelian Lebih dari 3",
            ),
          ],
        ),
      ),
    );
  }
}

class MyAppBar extends StatefulWidget {
  @override
  _MyAppBarState createState() => _MyAppBarState();
}

class _MyAppBarState extends State<MyAppBar> {
  final myController = TextEditingController();

  @override
  void dispose() {
    // Clean up the controller when the Widget is removed from the Widget tree
    myController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          IconButton(
            onPressed: () {
              Scaffold.of(context).openDrawer();
            },
            icon: Icon(Icons.menu),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: Container(
                height: 40.0,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.0),
                    border: Border.all(color: Colors.grey, width: 2.0)),
                child: InkWell(
                  onTap: () {
                    Application.router.navigateTo(context, "/instantsearch",
                        transition: TransitionType.fadeIn);
                  },
                  splashColor: Colors.blueGrey,
                  borderRadius: BorderRadius.circular(15.0),
                  child: Row(
                    children: <Widget>[
                      SizedBox(
                        width: 20.0,
                      ),
                      Expanded(
                        child: Text(
                          "Cari Makanan...",
                          style: TextStyle(color: Colors.grey, fontSize: 14.0),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          )
        ],
      ),
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
      padding: const EdgeInsets.only(right: 8.0),
      child: Container(
          height: 160.0,
          width: 300.0,
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage(gambar), fit: BoxFit.cover)),
          child: Stack(
            children: <Widget>[
              Container(
                height: 160.0,
                width: 300.0,
                decoration: BoxDecoration(
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

class Category extends StatelessWidget {
  final IconData iconData;
  final String nama;
  final Color warnaicon;
  final Color warnaback;

  const Category(
      {Key key, this.iconData, this.nama, this.warnaicon, this.warnaback})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Application.router.navigateTo(context, "/search?query=$nama",
            transition: TransitionType.fadeIn);
      },
      child: Container(
        height: 92.0,
        width: 124.0,
        decoration: BoxDecoration(
            color: warnaback, borderRadius: BorderRadius.circular(10.0)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Icon(
              iconData,
              color: warnaicon,
            ),
            SizedBox(
              height: 5.0,
            ),
            Text(
              nama,
              style: TextStyle(color: green, fontWeight: FontWeight.w500),
            )
          ],
        ),
      ),
    );
  }
}
