import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:masihokeh/main.dart';
import 'package:masihokeh/pages/signup_screen.dart';

class UserManagement {
  Future signOut(BuildContext context) async {
    await FirebaseAuth.instance.signOut();
    Application.router.navigateTo(context, "/login");
  }

  Future<String> storeNewUser(DataDiri data, context) async {
    String value;
    AuthResult result = await FirebaseAuth.instance
        .createUserWithEmailAndPassword(
            email: data.email, password: data.password)
        .catchError((e) {
      print(e);
      Navigator.pop(context);
      Fluttertoast.showToast(
          msg: "Email sudah pernah digunakan",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIos: 3,
          backgroundColor: Colors.grey.withOpacity(0.8),
          textColor: Colors.white,
          fontSize: 16.0);
    });
    FirebaseUser user = result.user;
    var a = await Firestore.instance.collection('/users').add({
      'email': user.email,
      'uid': user.uid,
      'namadepan': data.namadepan,
      'namabelakang': data.namabelakang,
      'noHP': data.noHP
    }).then((value) {
      Navigator.pop(context);
      Fluttertoast.showToast(
          msg: "Login Berhasil",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIos: 3,
          backgroundColor: Colors.grey.withOpacity(0.8),
          textColor: Colors.white,
          fontSize: 16.0);
      print("asd");
      print(value.documentID);
      return value.documentID;
      // Application.router.pop(context);
      // Application.router.navigateTo(context, "/");
    }).catchError((e) {
      print(e);
      value = 'error';
      return value;
    });
    if (value == 'error') {
      return value;
    } else {
      return a;
    }
  }

  signIn(String email, String password) async {
    AuthResult results = await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password);
    FirebaseUser user = results.user;
    print(user.uid);
    return user;
  }
}
