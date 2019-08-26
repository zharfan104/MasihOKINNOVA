import 'package:flutter/material.dart';

class CustomAppBar extends StatefulWidget {
  @override
  _CustomAppBarState createState() => _CustomAppBarState();
}

class _CustomAppBarState extends State<CustomAppBar>
    with SingleTickerProviderStateMixin {
  // AnimationController animation;
  // @override
  // void initState() {
  //   super.initState();
  //   animation =
  //       AnimationController(vsync: this, duration: Duration(milliseconds: 500));
  //   animation.addListener(() {
  //     this.setState(() {});
  //   });

  //   animation.forward();
  // }

  // @override
  // void dispose() {
  //   animation.dispose();
  //   super.dispose();
  // }

  TextEditingController _controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80.0,
      child: Stack(
        children: <Widget>[
          Container(
            color: Color(0xFF36E06C),
            width: MediaQuery.of(context).size.width,
            height: 50.0,
            child: Center(),
          ),
          Positioned(
            top: 20.0,
            left: 0.0,
            right: 0.0,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 20.0),
              child: DecoratedBox(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.0),
                    border: Border.all(
                        color: Color(0xFF36E06C).withOpacity(0.5), width: 1.0),
                    color: Colors.white),
                child: Row(
                  children: [
                    IconButton(
                      icon: Icon(
                        Icons.menu,
                        color: Colors.red,
                      ),
                      onPressed: () => Scaffold.of(context).openDrawer(),
                    ),
                    Expanded(
                      child: TextField(
                        controller: _controller,
                        decoration: InputDecoration.collapsed(
                            hintText: "Cari makanan...", fillColor: Colors.red),
                      ),
                    ),
                    IconButton(
                      icon: Icon(
                        Icons.search,
                        color: Colors.green,
                      ),
                      onPressed: () {
                        print("your menu action here");
                      },
                    ),
                    IconButton(
                      icon: Icon(
                        Icons.shopping_basket,
                        color: Colors.green,
                      ),
                      onPressed: () {
                        print("your menu action here");
                      },
                    ),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
