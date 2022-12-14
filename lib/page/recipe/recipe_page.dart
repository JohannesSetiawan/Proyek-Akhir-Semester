import 'package:flutter/material.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:provider/provider.dart';

import '../../model/user_data.dart';
import '../../model/foodrecipe.dart';
import '../../util/recipe_formatter.dart';
import '../home/drawer.dart';
import 'add_recipe.dart';
import 'recipe_details.dart';

class RecipePage extends StatefulWidget {
  const RecipePage({Key? key}) : super(key: key);

  @override
  State<RecipePage> createState() => _RecipePageState();
}

class _RecipePageState extends State<RecipePage> {
  @override
  Widget build(BuildContext context) {
    final request = context.watch<CookieRequest>();
    final args = ModalRoute.of(context)!.settings.arguments as UserArguments;
    // ignore: unused_element
    Future<List<FoodRecipe>> fetchFoodRecipe() async {
      final response =
          await request.get("https://nutrious.up.railway.app/recipe/json/");
      // ignore: avoid_print
      // print("AAAAAAAAAAAAAAAAAAAAAAAAA");
      // print(response);
      List<FoodRecipe> listFoodRecipe = [];
      for (var recipe in response) {
        if (recipe != null) {
          listFoodRecipe.add(FoodRecipe.fromJson(recipe));
        }
      }
      return listFoodRecipe;
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
          child: Column(children: [
        Expanded(
          flex: 4,
          
          child: Container(
            decoration: const BoxDecoration(   
              borderRadius: BorderRadius.all(Radius.circular(10.0)),     
              image: DecorationImage(
                image: AssetImage("images/recipe-header.png"),  
                fit: BoxFit.cover,
              ),
            ),
            margin: const EdgeInsets.fromLTRB(10, 10, 10, 0),
            child: const Center(
              child: Text(
                "List of Recipes",
                style: TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 20,
                    color: Colors.white),
              ),
            ),
          ),
        ),
        
        Expanded(
          flex: 10,
          child: FutureBuilder(
            future: fetchFoodRecipe(),
            builder: (context, AsyncSnapshot snapshot) {
              if (snapshot.data == null) {
                return const Center(child: CircularProgressIndicator());
              } else {
                if (!snapshot.hasData) {
                  return const Text("No Recipe Shared");
                } else {
                  return ListView.builder(
                    padding: const EdgeInsets.all(7),
                    itemCount: snapshot.data!.length,
                    itemBuilder: (_, index) => Container(
                        padding: const EdgeInsets.all(10),
                        margin: const EdgeInsets.all(5),
                        height: 130,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: const [
                              BoxShadow(color: Colors.black, blurRadius: 2.0)
                            ]),
                        child: InkWell(
                          onTap: () {
                            Future.delayed(Duration.zero, () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => RecipeDetail(
                                          recipe: snapshot.data![index],
                                          args: args)));
                            });
                          },
                          child: Column(
                            children: [
                              Expanded(
                                flex: 1,
                                child: Align(
                                  alignment: Alignment.topLeft,
                                  child: Text(
                                    snapshot.data![index].foodName,
                                    textAlign: TextAlign.left,
                                    overflow: TextOverflow.ellipsis,
                                    style: const TextStyle(
                                        fontWeight: FontWeight.w700,
                                        fontSize: 20),
                                  ),
                                ),
                              ),
                              Expanded(
                                flex: 1,
                                child: Align(
                                    alignment: Alignment.topLeft,
                                    child: Text(
                                        "Created by ${snapshot.data![index].authorName}, ${snapshot.data![index].formattedDate} ")
                                        ),
                              ),
                              Expanded(
                                flex: 1,
                                child: Row(
                                  children: [
                                    Expanded(
                                      flex: 7,
                                      child: Text(
                                          "Ingredients: ${RecipeFormat.reformatPage(snapshot.data![index].ingredients)}", overflow: TextOverflow.ellipsis, maxLines: 1),
                                    ),
                                  ],
                                ),
                              ),
                              Expanded(
                                flex: 1,
                                child: Row(
                                  children: [
                                    Expanded(
                                      flex: 7,
                                      child: Text(
                                          "Methods: ${RecipeFormat.reformatPage(snapshot.data![index].method)}", overflow: TextOverflow.ellipsis, maxLines: 1),
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                        )),
                  );
                }
              }
            },
          ),
        ),
      ])),
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: Colors.green,
        onPressed: () {
          Future.delayed(Duration.zero, () {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => AddRecipe(args: args),
                ));
          });
        },
        label: const Text(
          'Add recipe',
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}
