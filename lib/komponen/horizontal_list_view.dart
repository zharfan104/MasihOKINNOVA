import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

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

class HorizontalList extends StatefulWidget {
  final Widget child;

  HorizontalList({Key key, this.child}) : super(key: key);

  _HorizontalListState createState() => _HorizontalListState();
}

class _HorizontalListState extends State<HorizontalList> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Container(
          height: 92.0,
          width: 124.0,
          color: greenLight,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Icon(
                FontAwesomeIcons.footballBall,
                color: green,
              ),
              SizedBox(
                height: 4.0,
              ),
              Text(
                'Sports store',
                style: TextStyle(color: green, fontWeight: FontWeight.w500),
              )
            ],
          ),
        ),
        Container(
          height: 92.0,
          width: 124.0,
          color: redLight,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Icon(
                FontAwesomeIcons.solidClock,
                color: red,
              ),
              SizedBox(
                height: 4.0,
              ),
              Text(
                'Book a Table',
                style: TextStyle(color: red, fontWeight: FontWeight.w500),
              )
            ],
          ),
        ),
        Container(
          height: 92.0,
          width: 124.0,
          color: blueLight,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Icon(
                FontAwesomeIcons.solidLaugh,
                color: blue,
              ),
              SizedBox(
                height: 4.0,
              ),
              Text(
                'Caterings',
                style: TextStyle(color: blue, fontWeight: FontWeight.w500),
              )
            ],
          ),
        ),
      ],
    );
  }
}

class Category extends StatelessWidget {
  final String imageLocation;
  final String imageCaption;

  const Category({Key key, this.imageLocation, this.imageCaption})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(1.0),
      child: Container(
        decoration: BoxDecoration(
            border: Border.all(color: Colors.black, style: BorderStyle.solid),
            borderRadius: BorderRadius.circular(20.0)),
        width: 100.0,
        height: 200.0,
        child: InkWell(
          borderRadius: BorderRadius.circular(20.0),
          onTap: () {},
          child: Center(
            child: ListTile(
              title: Image(
                width: 100.0,
                height: 50.0,
                image: AssetImage(imageLocation),
              ),
              subtitle: Container(
                alignment: Alignment.topCenter,
                child: Text(
                  imageCaption,
                  style: TextStyle(fontSize: 20.0),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
