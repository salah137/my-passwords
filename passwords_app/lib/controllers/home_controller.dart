import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';
import 'package:passwords_app/components/components.dart';
import 'package:passwords_app/components/consts.dart';
import 'package:passwords_app/controllers/user_auth_controller.dart';
import 'package:passwords_app/models/passwordModel.dart';
import 'dart:math';
import 'package:passwords_app/views/HomeScreen.dart';

class MainController extends GetxController {
  @override
  void onInit() async {
    await getAllData();
    super.onInit();
  }

  var isLoa = false.obs;
  var passwords = <PasswordModel>[].obs;

  var imp = 20.0.obs;

  void addPassword(ctx) async {
    TextEditingController n = TextEditingController();
    TextEditingController password = TextEditingController();
    TextEditingController desk = TextEditingController();
    TextEditingController url = TextEditingController();
    MainController c = Get.put(MainController());
    Get.bottomSheet(
      Obx(() {
        return Form(
          child: Container(
            height: double.infinity,
            margin: EdgeInsets.all(10),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                Expanded(
                    child: buildInputFeild(
                  n,
                  "what is the web site name",
                  true,
                  (v) {},
                  false,
                )),
                Expanded(
                    child: buildInputFeild(
                  url,
                  "the url",
                  false,
                  (v) {},
                  false,
                )),
                Expanded(
                    child: buildInputFeild(
                        desk, "desckription", true, (v) {}, false,
                        maxLines: 2)),
                Expanded(
                  child: Container(
                    height: 50,
                    child: Row(
                      children: [
                        Expanded(
                          child: buildInputFeild(
                              password, "Password", false, (v) {}, false),
                        ),
                        Container(
                          height: 50,
                          decoration: BoxDecoration(
                              color: Colors.red,
                              borderRadius: BorderRadius.circular(10)),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: MaterialButton(
                              onPressed: () {
                                password.text = getRandPasswords();
                              },
                              child: Text("Generate"),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                Expanded(
                    child: Slider(
                  activeColor: Color.fromRGBO(c.imp.value.toInt(), 50, 0, 1),
                  onChanged: (v) {
                    c.imp.value = v;
                  },
                  value: c.imp.value,
                  max: 155,
                  min: 20,
                )),
                Container(
                  width: double.infinity,
                  height: 50,
                  decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(10)),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: MaterialButton(
                      onPressed: () async {
                        var passowrd = PasswordModel(
                          password: password.text,
                          title: n.text == null ? "nothing" : n.text,
                          desk: desk == null ? desk.text : "nothing",
                          important: imp.value,
                          url: url.text,
                        );
                        FirebaseFirestore.instance
                            .collection("users")
                            .doc(UserController.user!.user!.uid)
                            .collection("passowerds")
                            .doc(n.text)
                            .set(passowrd.toMap());
                        await getAllData();
                        Navigator.of(ctx).pop();
                      },
                      child: Text("Generate"),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      }),
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
        topRight: Radius.circular(15),
        topLeft: Radius.circular(15),
      )),
      backgroundColor: Colors.white,
    );
  }

  getAllData() async {
    isLoa.value = true;
    print('iii+');
    await FirebaseFirestore.instance
        .collection("users")
        .doc(UserController.user!.user!.uid)
        .collection("passwords")
        .get()
        .then((value) {
      for (var i in value.docs) {
        print('done');
        passwords.add(PasswordModel(
            password: i["password"],
            title: i["title"],
            important: i["import"],
            url: i["url"],
            desk: i["desk"]));
        passwords.forEach((element) {
          print(element.title);
        });
        isLoa.value = false;
      }
    });
  }

  getRandPasswords() {
    const alphbets = [
      "a",
      "z",
      "e",
      "r",
      "t",
      "y",
      "u",
      "i",
      "o",
      "p",
      "q",
      "s",
      "d",
      "f",
      "g",
      "h",
      "j",
      "k",
      "l",
      "m",
      "w",
      "x",
      "c",
      "v",
      "b",
      "n"
    ];
    const spechialCharac = [
      "²",
      "~",
      "#",
      "{",
      "[",
      "|",
      "`",
      "\\",
      "^",
      "@",
      "]",
      "}",
      "&",
      "é",
      "\"",
      "\'",
      "(",
      "-",
      "_",
      "ç",
      "à",
      ")",
      "}",
      "§",
      "!",
      ":",
      ";",
      ",",
      "?",
      "+",
      "-",
      "*",
      "/",
    ];

    getRandom() {
      return Random().nextInt(10);
    }

    var numbersIndexs = [
      getRandom(),
      getRandom(),
      getRandom(),
      getRandom(),
    ];

    var spechialCharacIndexs = [
      getRandom(),
      getRandom(),
      getRandom(),
      getRandom(),
    ];

    var capitalChatInexs = [
      getRandom(),
      getRandom(),
    ];

    var password = "";

    for (var i = 0; i < 10; i++) {
      if (i == capitalChatInexs[0])
        password += alphbets[getRandom()].toUpperCase();
      else if (i == capitalChatInexs[1])
        password += alphbets[getRandom()].toString().toUpperCase();
      else if (spechialCharacIndexs[0] == i)
        password += spechialCharac[getRandom()];
      else if (spechialCharacIndexs[1] == i)
        password += spechialCharac[getRandom()];
      else if (spechialCharacIndexs[2] == i)
        password += spechialCharac[getRandom()];
      else if (spechialCharacIndexs[3] == i)
        password += spechialCharac[getRandom()];
      else if (numbersIndexs[0] == i)
        password += getRandom().toString();
      else if (numbersIndexs[1] == i)
        password += getRandom().toString();
      else if (numbersIndexs[2] == i)
        password += getRandom().toString();
      else if (numbersIndexs[3] == i)
        password += getRandom().toString();
      else
        password += alphbets[getRandom()];
    }
    return password;
  }
}
