import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:masihokeh/models/ItemProduk.dart';

class crudMethoods {
  bool isLoggedIn() {
    if (FirebaseAuth.instance.currentUser() != null) {
      return true;
    } else {
      return false;
    }
  }

  Future<void> addProdukLogic(produk) async {
    if (isLoggedIn()) {
      Firestore.instance.collection("produk").add(produk).catchError((e) {
        print(e);
      });
    } else {
      print("You Have to Login");
    }
  }
}
