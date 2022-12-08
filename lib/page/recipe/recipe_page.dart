import 'package:flutter/material.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:provider/provider.dart';
// import 'package:nutrious/util/curr_converter.dart';
import '../../model/user_data.dart';
import '../home/drawer.dart';

class RecipePage extends StatefulWidget {
  const RecipePage({Key? key}) : super(key: key);

  @override
  State<RecipePage> createState() => _RecipePageState();
}

class _RecipePageState extends State<RecipePage> {
  @override
  Widget build(BuildContext context) {
    // ignore: unused_local_variable
    final request = context.watch<CookieRequest>();
    final args = ModalRoute.of(context)!.settings.arguments as UserArguments;
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
      body: ListView(
        children: [
           Container(
                padding: const EdgeInsets.all(10),
                child: Column(
                  children: [
                    Stack(
                      alignment: Alignment.center,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(30),
                          child: Image.asset('images/recipe-header.png'),
                        ),
                        Container(
                          padding: const EdgeInsets.all(8),
                          child: Column(
                            children: const [
                              Center(child: Text("Food Recipes", textAlign: TextAlign.center, style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w700,
                                color: Colors.white
                              ),)),
                              SizedBox(height: 3,),
                              Center(child: Text("Find your food inspirations and make your own food here. You can also help others by posting your own recipes ;)", textAlign: TextAlign.center, style: TextStyle(
                                fontSize: 15,
                                color: Colors.white
                              ),))
                            ],
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ),
        ],
      ),
      
    );
  }
}
