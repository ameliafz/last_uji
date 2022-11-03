import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Firebase_Auth {
  FirebaseAuth Auth = FirebaseAuth.instance;

  Stream<User?> AuthStatus() {
    return Auth.authStateChanges();
  }

  Future login({required String email, required String password}) async {
    try {
      await Auth.signInWithEmailAndPassword(email: email, password: password);
    } on FirebaseAuthException catch (e) {
      if (e.code == "user-not-found") {
        // print("tidak ada user yang ditemukan");
        return true;
      } else if (e.code == "wrong-password") {
        // print("password yang anda masukkan salah");
        return false;
      }
    }
  }

  Future register(
      {required String email,
      required String password,
      required String nama,
      required String nomer}) async {
    try {
      var result = await Auth.createUserWithEmailAndPassword(
          email: email, password: password);
      User? user = result.user;
      user?.updateDisplayName(nama);
      FirebaseFirestore.instance
          .collection('user_detail')
          .doc()
          .set({'Nama': nama, 'Phone': nomer, 'Id': user?.uid});
      return true;
    } catch (err) {
      print(err.toString());
      return false;
    }
  }

  Future logout() async {
    await Auth.signOut();
  }
}