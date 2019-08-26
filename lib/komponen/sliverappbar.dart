import 'package:flutter/material.dart';

class MainCollapsingToolbar extends StatefulWidget {
  @override
  _MainCollapsingToolbarState createState() => _MainCollapsingToolbarState();
}

class _MainCollapsingToolbarState extends State<MainCollapsingToolbar> {
  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: <Widget>[
        SliverAppBar()
      ],
    );
  }
}
