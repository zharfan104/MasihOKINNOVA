import 'package:flutter/material.dart';
class RecieptDetails extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("as"),backgroundColor: Colors.green,),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Container(
            height: 250.0,
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(20.0),
                border: Border.all(color: Colors.black, width: 1.0)),
            child: Image.asset("assets/susu.jpg"),),
          Container(
            height: 300.0,
            decoration: BoxDecoration(color: Colors.lightGreenAccent),
            child: Text("Asu", style: TextStyle(fontSize: 30.0),),
          ),

        ],
      ),


    );
  }
}
