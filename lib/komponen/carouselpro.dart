import 'package:flutter/material.dart';
import 'package:carousel_pro/carousel_pro.dart';

class Carousell extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10.0),
      child: SizedBox(
          height: MediaQuery.of(context).size.height * 0.25,
          width: MediaQuery.of(context).size.width * 0.95,
          child: new Carousel(
            images: [
              AssetImage('assets/1.jpg'),
              AssetImage('assets/2.jpg'),
              AssetImage('assets/3.jpg')
            ],
            dotSize: 2.0,
            dotSpacing: 15.0,
            dotColor: Colors.lightGreenAccent,
            indicatorBgPadding: 5.0,
            dotBgColor: Colors.transparent,
            borderRadius: true,
          )),
    );
  }
}
