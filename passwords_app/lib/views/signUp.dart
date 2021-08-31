import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:passwords_app/components/components.dart';
import 'package:passwords_app/components/consts.dart';
import 'package:passwords_app/controllers/user_auth_controller.dart';
import 'package:passwords_app/views/signIn.dart';

class SingUpScreen extends StatelessWidget {
      TextEditingController email = TextEditingController();
    TextEditingController user = TextEditingController();
    TextEditingController password = TextEditingController();
    GlobalKey<FormState> fkey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    final UserController controller = Get.put(UserController());

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
                    buildInputFeild(user, "user name", true, (String? v) {
                      if (v == null || v.isEmpty) return "entre your user name";
                      return null;
                    }, false),
                    SizedBox(
                      height: MediaQuery.of(context).size.height / 20,
                    ),
                    GestureDetector(
                      onTap: () {
                        if (fkey.currentState!.validate()) {
                          controller.signUp(
                              email.text, password.text, user.text);
                        }
                      },
                      child: Container(
                        alignment: Alignment.center,
                        margin: EdgeInsets.symmetric(horizontal: 50),
                        child: AnimatedContainer(
                          duration: Duration(microseconds: 500),
                          child: controller.authLoadi.value
                              ? CircularProgressIndicator(
                                color: Colors.green,
                              )
                              : Text(
                                  "Done",
                                  style: TextStyle(
                                      fontFamily: ConstVars.fontF,
                                      fontSize: 25,
                                      color: Colors.green),
                                ),
                        ),
                        height: 70,
                        width: MediaQuery.of(context).copyWith().size.width,
                        decoration: BoxDecoration(
                          color: Colors.red,
                          borderRadius: BorderRadius.only(
                            bottomRight: Radius.circular(180),
                            topLeft: Radius.circular(180),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height / 50,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Have You An Account ??',
                          style: TextStyle(
                            fontFamily: "Schyler",
                            fontSize: 15,
                          ),
                        ),
                        TextButton(
                          onPressed: () {
                            Get.to(()=>SingInScreen());
                          },
                          child: Text(
                            'SING IN NOW',
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
