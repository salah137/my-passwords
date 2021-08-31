import "package:flutter/material.dart";
import 'package:get/get_core/src/get_main.dart';
import 'package:passwords_app/components/components.dart';
import 'package:passwords_app/controllers/home_controller.dart';
import 'package:get/get.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
     final MainController c = Get.put(MainController());
    return Obx(
      ()  {

        return c.isLoa.value? Scaffold(
                  body: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                     myLogo(context),
                     CircularProgressIndicator(),
                    ],
                  ),
                ): Scaffold(
          body: CustomScrollView(

            physics: BouncingScrollPhysics(),
            slivers: [
              SliverAppBar(
              leading: Text(""),
                actions: [],
                backgroundColor: Colors.red,
                expandedHeight: MediaQuery.of(context).size.height / 5,
                shape: RoundedRectangleBorder(
                    borderRadius:
                        BorderRadius.only(bottomRight: Radius.circular(180))),
              ),
              SliverList(
                delegate: SliverChildListDelegate(c.passwords
                    .map((element) => itemBuilder(context, element))
                    .toList()),
              )
            ],
          ),
          floatingActionButton: FloatingActionButton(
            backgroundColor: Colors.red,
            child: Icon(Icons.add),
            onPressed: ()=>c.addPassword(context),

          ),
        );
      },
    );
  }
}
