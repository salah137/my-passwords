import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:passwords_app/controllers/home_controller.dart';
import 'package:passwords_app/views/HomeScreen.dart';

class UserController extends GetxController {
  var uerPassWords = [].obs;
   var authLoadi = false.obs;
  static UserCredential? user ;
  @override
  void onInit() {
    super.onInit();
  }

  Future signUp(String email, String password, String userName) async {
    authLoadi.value = true;
    try {
      var userx= await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
      await FirebaseFirestore.instance
          .collection("users")
          .doc(userx.user!.uid)
          .set(
        {
          "userName": userName,
          "passwords": [
            {
              "password": "ezfgv-trc-é",
              "websiteName": "fac",
              "link": "https://pub.dev/packages/animated_text_kit"
            }
          ]
        },
      );
      user = userx;
      authLoadi.value = false;

      Get.to(()=>HomePage());

    } catch (e) {
      var error = e.toString();
      Get.snackbar("error", error.substring(error.indexOf("]") + 1),
          backgroundColor: Colors.red, snackPosition: SnackPosition.BOTTOM);
      authLoadi.value = false;
    }
  }
    Future signIn(String email, String password, ) async {
    authLoadi.value = true;
    try {
      var userx = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      user = userx;

      authLoadi.value = false;
      Get.to(()=>HomePage());

    } catch (e) {
      var error = e.toString();
      Get.snackbar("error", error.substring(error.indexOf("]") + 1),
          backgroundColor: Colors.red, snackPosition: SnackPosition.BOTTOM);
      authLoadi.value = false;
    }
  }
}
