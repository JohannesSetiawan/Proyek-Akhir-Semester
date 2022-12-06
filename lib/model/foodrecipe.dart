// To parse this JSON data, do
//
//     final foodRecipe = foodRecipeFromJson(jsonString);

import 'dart:convert';

List<FoodRecipe> foodRecipeFromJson(String str) => List<FoodRecipe>.from(json.decode(str).map((x) => FoodRecipe.fromJson(x)));

String foodRecipeToJson(List<FoodRecipe> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class FoodRecipe {
    FoodRecipe({
        required this.model,
        required this.pk,
        required this.fields,
    });

    Model? model;
    int pk;
    Fields fields;

    factory FoodRecipe.fromJson(Map<String, dynamic> json) => FoodRecipe(
        model: modelValues.map[json["model"]],
        pk: json["pk"],
        fields: Fields.fromJson(json["fields"]),
    );

    Map<String, dynamic> toJson() => {
        "model": modelValues.reverse[model],
        "pk": pk,
        "fields": fields.toJson(),
    };
}

class Fields {
    Fields({
        required this.foodName,
        required this.author,
        required this.authorName,
        required this.ingredients,
        required this.method,
        required this.createdOn,
        required this.formattedDate,
    });

    String foodName;
    int author;
    String authorName;
    String ingredients;
    String method;
    DateTime createdOn;
    String formattedDate;

    factory Fields.fromJson(Map<String, dynamic> json) => Fields(
        foodName: json["food_name"],
        author: json["author"],
        authorName: json["author_name"],
        ingredients: json["ingredients"],
        method: json["method"],
        createdOn: DateTime.parse(json["created_on"]),
        formattedDate: json["formatted_date"],
    );

    Map<String, dynamic> toJson() => {
        "food_name": foodName,
        "author": author,
        "author_name": authorName,
        "ingredients": ingredients,
        "method": method,
        "created_on": createdOn.toIso8601String(),
        "formatted_date": formattedDate,
    };
}

// ignore: constant_identifier_names
enum Model { RECIPE_FOODRECIPE }

final modelValues = EnumValues({
    "recipe.foodrecipe": Model.RECIPE_FOODRECIPE
});

class EnumValues<T> {
    Map<String, T> map;
    late Map<T, String> reverseMap;

    EnumValues(this.map);

    Map<T, String> get reverse {
        // ignore: prefer_conditional_assignment, unnecessary_null_comparison
        if (reverseMap == null) {
            // ignore: unnecessary_new
            reverseMap = map.map((k, v) => new MapEntry(v, k));
        }
        return reverseMap;
    }
}
