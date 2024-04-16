import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fa9ran/ui/pages/main_page.dart';
import 'package:fa9ran/ui/pages/splash_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AuthController extends GetxController{
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
   late Rx<User?> _user;
  User get user => _user.value!;
  @override
  void onReady() {
    super.onReady();
    _user = Rx<User?>(FirebaseAuth.instance.currentUser);
    _user.bindStream(FirebaseAuth.instance.authStateChanges());
    ever(_user, _setInitialScreen);
  }

  _setInitialScreen(User? user) {
    if (user == null) {
      Get.off(() => const SplashPage());
    } else {
      Get.off(() => const MainPage());
    }
  }

  Future<String> registerNewUser(
    String email,
    String password,
    String firstName,
    String lastName,
    String phoneNumber,
    BuildContext context,
  ) async {
    String res = 'something went wrong';

    try {
      // we want to create the user first in the authentication tab and then in the cloud firestore

      UserCredential userCredential = await _auth
          .createUserWithEmailAndPassword(email: email, password: password);

      await _firestore.collection('buyers').doc(userCredential.user!.uid).set({
        'buyerId': _auth.currentUser!.uid,
        "fullName": '',
        'email': email,
        'firstName': firstName,
        'lastName': lastName,
        'profileImage': "",
        'address': '',
        'country': '',
        'phoneNumber': phoneNumber,
      });
      res = 'success';
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        res = 'The password provided is too weak.';
      } else if (e.code == 'email-already-in-use') {
        res = 'The account already exists for that email.';
      }
    } catch (e) {
      res = e.toString();
    }

    return res;
  }

  ///LOGIN USER
  Future<String> loginUser(String email, String password) async {
    String res = 'something went wrong';

    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);

      res = "success";
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        res = 'No user found for that email.';
      } else if (e.code == 'wrong-password') {
        res = 'Wrong password provided for that user.';
      }
    } catch (e) {
      res = e.toString();
    }
    return res;
  }
}
