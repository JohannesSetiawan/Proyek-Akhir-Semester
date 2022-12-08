// To parse this JSON data, do
//
//     final calorie = calorieFromJson(jsonString);

import 'dart:convert';

Calorie calorieFromJson(String str) => Calorie.fromJson(json.decode(str));

String calorieToJson(Calorie data) => json.encode(data.toJson());

class Calorie {
    Calorie({
        required this.pk,
        required this.calorie,
        required this.description,
        required this.category,
        required this.isIncreasing,
        required this.date,
        required this.time,
    });

    int pk;
    int calorie;
    String description;
    String category;
    bool isIncreasing;
    DateTime date;
    String time;

    factory Calorie.fromJson(Map<String, dynamic> json) => Calorie(
        pk: json["pk"],
        calorie: json["calorie"],
        description: json["description"],
        category: json["category"],
        isIncreasing: json["is_increasing"],
        date: DateTime.parse(json["date"]),
        time: json["time"],
    );

    Map<String, dynamic> toJson() => {
        "pk": pk,
        "calorie": calorie,
        "description": description,
        "category": category,
        "is_increasing": isIncreasing,
        "date": date.toIso8601String(),
        "time": time,
    };
}
