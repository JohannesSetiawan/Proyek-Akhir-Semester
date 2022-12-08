// To parse this JSON data, do
//
//     final foodsharing = foodsharingFromJson(jsonString);

import 'dart:convert';

List<Foodsharing> foodsharingFromJson(String str) => List<Foodsharing>.from(json.decode(str).map((x) => Foodsharing.fromJson(x)));

String foodsharingToJson(List<Foodsharing> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Foodsharing {
    Foodsharing({
        required this.pk,
        required this.author,
        required this.location,
        required this.description,
        required this.date,
        required this.updateDate,
        required this.img,
    });

    int pk;
    int author;
    String location;
    String description;
    String date;
    String updateDate;
    String img;

  

    factory Foodsharing.fromJson(Map<String, dynamic> json) => Foodsharing(
        pk: json["pk"],
        author: json["author"],
        location: json["location"],
        description: json["description"],
        date: json["date"],
        updateDate: json["update_date"],
        img: json["img"],
    );

    Map<String, dynamic> toJson() => {
        "pk":pk,
        "author": author,
        "location": location,
        "description": description,
        "date": date,
        "update_date": updateDate,
        "img": img,
    };
}
