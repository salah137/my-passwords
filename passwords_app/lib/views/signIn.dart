import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:passwords_app/components/components.dart';
import 'package:passwords_app/components/consts.dart';
import 'package:passwords_app/controllers/user_auth_controller.dart';
import 'package:passwords_app/views/signUp.dart';

class SingInScreen extends StatelessWidget {
  GlobalKey<FormState> fkey = GlobalKey<FormState>();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final UserController controller = Get.find();
    return Obx(
      () {
        return Scaffold(
          body: SafeArea(
            child: SingleChildScrollView(
              child: Form(
                key: fkey,
                child: Column(
                  children: [
                    myLogo(context),
                    buildInputFeild(email, "email", true, (String? v) {
                      if (!v!.contains("@")) return "the email is not valid";
                      if (v == null || v.isEmpty) return "entre your email";
                    }, false, keyTyp: TextInputType.emailAddress),
                    SizedBox(
                      height: MediaQuery.of(context).size.height / 20,
                    ),
                    buildInputFeild(password, "password", false, (String? v) {
                      if (v == null || v.isEmpty) return "entre your password";
                      return null;
                    }, true, keyTyp: TextInputType.visiblePassword),
                    SizedBox(
                      height: MediaQuery.of(context).size.height / 20,
                    ),
                    GestureDetector(
                      onTap: () {
                        if (fkey.currentState!.validate()) {
                          controller.signIn(
                            email.text,
                            password.text,
                          );
                        }
                      },
                      child: Container(
                        alignment: Alignment.center,
                        margin: EdgeInsets.symmetric(horizontal: 50),
                        child: AnimatedContainer(
                          duration: Duration(microseconds: 500),
                          child: controller.authLoadi.value
                              ? CircularProgressIndicator()
                              : Text(
                                  "Done",
                                  style: TextStyle(
                                      fontFamily: ConstVars.fontF,
                                      fontSize: 25,
                                      color: Colors.red),
                                ),
                        ),
                        height: 70,
                        width: MediaQuery.of(context).copyWith().size.width,
                        decoration: BoxDecoration(
                          color: Colors.green,
                          borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(180),
                            topRight: Radius.circular(180),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height / 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'You Have not any Account ??',
                          style: TextStyle(
                            fontFamily: "Schyler",
                            fontSize: 15,
                          ),
                        ),
                        TextButton(
                          onPressed: () {
                            Get.to(() => SingUpScreen());
                          },
                          child: Text(
                            'SING UP NOW',
                            style: TextStyle(
                                color: Colors.green,
                                fontWeight: FontWeight.bold),
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
