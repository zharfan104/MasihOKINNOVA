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
      'id': user.uid,
      'nama': data.namadepan + " " + data.namabelakang,
      'noHP': data.noHP,
      'toko': false,
      'photourl':
          'https://www.clipartwiki.com/clipimg/detail/197-1979569_no-profile.png',
      'poin': 0
    }).then((value) {
      Navigator.pop(context);
      Fluttertoast.showToast(
          msg: "Berhasil membuat akun, silahkan login",
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
    SharedPreferences prefrences;
    prefrences = await SharedPreferences.getInstance();

    AuthResult results = await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password);
    FirebaseUser user = results.user;
    if (user != null) {
      final QuerySnapshot result = await Firestore.instance
          .collection("users")
          .where("id", isEqualTo: user.uid)
          .getDocuments();
      final List<DocumentSnapshot> documents = result.documents;
      if (documents.length == 0) {
        Firestore.instance.collection("users").document(user.uid).setData({
          "id": user.uid,
          "photourl": user.photoUrl,
          "nama": user.displayName,
          "email": user.email,
          "masihokeh": false,
          "poin": 0
        });

        await prefrences.setString("id", user.uid);
        await prefrences.setString("nama", user.displayName);
        await prefrences.setString("email", user.email);
        await prefrences.setString("photourl", user.photoUrl);
        await prefrences.setBool("masihokeh", false);
        await prefrences.setInt("poin", 0);
      } else {
        await prefrences.setString("id", documents[0]['id']);
        await prefrences.setString("nama", documents[0]['nama']);
        await prefrences.setString("email", documents[0]['email']);
        await prefrences.setString("photourl", documents[0]['photourl']);
        await prefrences.setBool("masihokeh", documents[0]['masihokeh']);
        await prefrences.setInt("poin", documents[0]['poin']);
      }
      Fluttertoast.showToast(msg: "Login Berhasil");
    }
    print(user.uid);
    return user;
  }
}
