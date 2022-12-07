import 'package:flutter/material.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:provider/provider.dart';

import '../../model/foodsharing.dart';
import '../../model/user_data.dart';
import '../home/drawer.dart';
import 'add_foodsharing.dart';

class FoodSharingPage extends StatefulWidget {
  const FoodSharingPage({Key? key}) : super(key: key);

  @override
  State<FoodSharingPage> createState() => _FoodSharingPageState();
}

class _FoodSharingPageState extends State<FoodSharingPage> {
  @override
  Widget build(BuildContext context) {
    final request = context.watch<CookieRequest>();
    final args = ModalRoute.of(context)!.settings.arguments as UserArguments;
    Future<List<Foodsharing>> fetchFoodsharing() async {
      final response = await request
          .get("https://nutrious.up.railway.app/foodsharing/show_jsonf/");

      List<Foodsharing> listFoodsharing = [];
      for (var i in response["data"]) {
        if (i != null) {
          listFoodsharing.add(Foodsharing.fromJson(i));
        }
      }
      return listFoodsharing;
    }

    return Scaffold(
      appBar: AppBar(
          backgroundColor: const Color(0xFFF0FFFF),
          centerTitle: true,
          title: Image.asset('images/NUTRIOUS.png', height: 75),
          toolbarHeight: 100,
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(bottom: Radius.circular(30))),
          iconTheme: const IconThemeData(color: Colors.indigo)),
      drawer: DrawerMenu(
        isAdmin: args.isAdmin,
        username: args.username,
        description: args.desc,
        nickname: args.nickname,
        profileURL: args.profURL,
        isVerified: args.isVerified,
      ),

      body: Center(
        child: Column(
          children: [
            Expanded(
                flex: 1,
                child: Container(
                    margin: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                    child: Column(
                      children: [
                        const Text(
                          "Food-Sharing Information",
                          style: TextStyle(
                              fontWeight: FontWeight.w700, fontSize: 30),
                        ),
                        Text(
                          "\nHello, ${args.nickname}!",
                          style: const TextStyle(fontSize: 15),
                        ),
                        








                      Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        TextButton(
                          child: const Text(
                            "Add Page",
                            style: TextStyle(color: Colors.white),
                          ),
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all(Colors.blue),
                          ),
                          onPressed: () {
                            Navigator.push(context,
                                MaterialPageRoute(builder: (context) =>
                                    AddFoodsharingPage(args: args)));
                          },
                        ),
                       
                        ],
                    )



                    ]))),
                  
          ],
        ),
      ), // Center
    );
  }
}
