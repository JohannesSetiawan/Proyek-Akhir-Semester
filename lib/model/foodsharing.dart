// To parse this JSON data, do
//
//     final foodsharing = foodsharingFromJson(jsonString);

import 'dart:convert';

Foodsharing foodsharingFromJson(String str) => Foodsharing.fromJson(json.decode(str));

String foodsharingToJson(Foodsharing data) => json.encode(data.toJson());

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
    String author;
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
