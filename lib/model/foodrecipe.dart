// To parse this JSON data, do
//
//     final foodRecipe = foodRecipeFromJson(jsonString);

import 'dart:convert';

List<FoodRecipe> foodRecipeFromJson(String str) => List<FoodRecipe>.from(json.decode(str).map((x) => FoodRecipe.fromJson(x)));

String foodRecipeToJson(List<FoodRecipe> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class FoodRecipe {
    FoodRecipe({
        required this.pk,
        required this.foodName,
        required this.author,
        required this.authorName,
        required this.ingredients,
        required this.method,
        required this.createdOn,
        required this.formattedDate,
    });

   
    int pk;
    String foodName;
    int author;
    String authorName;
    String ingredients;
    String method;
    DateTime createdOn;
    String formattedDate;

    factory FoodRecipe.fromJson(Map<String, dynamic> json) => FoodRecipe(
        pk: json["pk"],
        foodName: json["food_name"],
        author: json["author"],
        authorName: json["author_name"],
        ingredients: json["ingredients"],
        method: json["method"],
        createdOn: DateTime.parse(json["created_on"]),
        formattedDate: json["formatted_date"],

    );

    Map<String, dynamic> toJson() => {
        "pk": pk,
        "food_name": foodName,
        "author": author,
        "author_name": authorName,
        "ingredients": ingredients,
        "method": method,
        "created_on": createdOn.toIso8601String(),
        "formatted_date": formattedDate,
    };
}


