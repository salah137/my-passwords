import 'package:flutter/material.dart';
import 'package:passwords_app/components/consts.dart';
import 'package:passwords_app/models/passwordModel.dart';

Widget buildInputFeild(controller, hint, isTrue, validator, isPass,
        {keyTyp = TextInputType.text, int maxLines = 1}) =>
    Container(
      margin: EdgeInsets.symmetric(horizontal: 50),
      child: TextFormField(
        maxLines: maxLines,
        validator: validator,
        controller: controller,
        decoration: InputDecoration(
          hintTextDirection: TextDirection.ltr,
          hintText: hint,
          hintStyle: TextStyle(
            fontFamily: ConstVars.fontF,
          ),
          border: isTrue
              ? const OutlineInputBorder(
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(10),
                    bottomLeft: Radius.circular(10),
                  ),
                  borderSide: const BorderSide(color: Colors.green, width: 2.0),
                )
              : const OutlineInputBorder(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10),
                    bottomRight: Radius.circular(10),
                  ),
                  borderSide: const BorderSide(color: Colors.red, width: 2.0),
                ),
          enabledBorder: isTrue
              ? const OutlineInputBorder(
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(10),
                    bottomLeft: Radius.circular(10),
                  ),
                  borderSide: const BorderSide(color: Colors.green, width: 2.0),
                )
              : const OutlineInputBorder(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10),
                    bottomRight: Radius.circular(10),
                  ),
                  borderSide: const BorderSide(color: Colors.red, width: 2.0),
                ),
        ),
        obscureText: isPass,
        keyboardType: keyTyp,
      ),
    );

Widget myLogo(context) => Stack(
      alignment: Alignment.center,
      children: [
        Container(
          margin: EdgeInsets.all(25),
          height: 268,
          width: MediaQuery.of(context).copyWith().size.width,
          decoration: BoxDecoration(
              color: Colors.green,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(180),
                topRight: Radius.circular(180),
              )),
        ),
        Container(
          alignment: Alignment.center,
          child: Text(
            "My Passwords",
            style: TextStyle(
                fontSize: 35, fontFamily: ConstVars.fontF, color: Colors.green),
          ),
          margin: EdgeInsets.all(25),
          height: 268,
          width: MediaQuery.of(context).copyWith().size.width,
          decoration: BoxDecoration(
              color: Colors.red,
              borderRadius: BorderRadius.only(
                bottomRight: Radius.circular(180),
                topLeft: Radius.circular(180),
              )),
        )
      ],
    );

Widget itemBuilder(context,PasswordModel model) => Container(
      margin: EdgeInsets.all(20),
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        color: Color.fromRGBO(model.important.toInt(), 50, 0, 1),
        borderRadius: BorderRadius.circular(20),
      ),
      height: MediaQuery.of(context).size.height / 7,
      child: ListTile(
        title: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            "${model.title}",
            style: TextStyle(
                fontSize: 30, fontFamily: ConstVars.fontF, color: Colors.white),
          ),
        ),
        subtitle: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: Text(
            "${model.desk}",
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
                color: Colors.white, fontSize: 15, fontFamily: ConstVars.fontF),
          ),
        ),
      ),
    );
