import 'package:flutter/material.dart';
import '../../model/foodrecipe.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:provider/provider.dart';
import '../../util/recipe_formatter.dart';

class RecipeDetail extends StatefulWidget {
  final FoodRecipe recipe;
  final args;

  const RecipeDetail({super.key, required this.recipe, required this.args});

  @override
  State<RecipeDetail> createState() => _RecipeDetailState();
}

class _RecipeDetailState extends State<RecipeDetail> {
  @override
  Widget build(BuildContext context) {
    final request = context.watch<CookieRequest>();
    final recipe = widget.recipe;
    final args = widget.args;
    return Scaffold(
        appBar: AppBar(
          backgroundColor: const Color(0xFFF0FFFF),
          centerTitle: true,
          title: Image.asset('images/NUTRIOUS.png', height: 75),
          toolbarHeight: 100,
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(bottom: Radius.circular(30))),
          iconTheme: const IconThemeData(color: Colors.indigo),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () => Navigator.of(context).pop(),
          ),
        ),
        body: Center(
            child: ListView(children: [
          Container(
              margin: const EdgeInsets.all(15),
              child: Column(children: [
                Text(
                  recipe.foodName,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 25,
                  ),
                ),
                Text(
                  "Created by ${recipe.authorName}",
                  style: const TextStyle(fontSize: 16),
                ),
                Text(
                  "on ${recipe.formattedDate}",
                  style: const TextStyle(fontSize: 16),
                ),
              ])),
          Container(
            margin:
                const EdgeInsets.only(left: 20, top: 0, right: 20, bottom: 0),
            child: Column(
              children: [
                const Text(
                  "Ingredients",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontWeight: FontWeight.w700, fontSize: 18),
                ),
                Text(
                  RecipeFormat.reformatDetail(recipe.ingredients),
                  style: const TextStyle(fontSize: 16),
                ),
              ],
            ),
          ),
          Container(
            margin:
                const EdgeInsets.only(left: 20, top: 0, right: 20, bottom: 0),
            child: Column(
              children: [
                const Text(
                  "Step by step:",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontWeight: FontWeight.w700, fontSize: 18),
                ),
                Text(
                  RecipeFormat.reformatDetail(recipe.method),
                  style: const TextStyle(fontSize: 16),
                ),
              ],
            ),
          ),
          Container(
            margin: const EdgeInsets.all(10),
            child: const Text(
              "Happy cooking ;)",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontStyle: FontStyle.italic,
                fontSize: 18,
              ),
            ),
          ),
        ])));
  }
}
