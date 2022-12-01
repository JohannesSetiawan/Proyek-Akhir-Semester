// To parse this JSON data, do
//
//     final message = messageFromJson(jsonString);

import 'dart:convert';

List<Message> messageFromJson(String str) => List<Message>.from(json.decode(str).map((x) => Message.fromJson(x)));

String messageToJson(List<Message> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Message {
  Message({
    required this.model,
    required this.pk,
    required this.fields,
  });

  String model;
  int pk;
  Fields fields;

  factory Message.fromJson(Map<String, dynamic> json) => Message(
    model: json["model"],
    pk: json["pk"],
    fields: Fields.fromJson(json["fields"]),
  );

  Map<String, dynamic> toJson() => {
    "model": model,
    "pk": pk,
    "fields": fields.toJson(),
  };
}

class Fields {
  Fields({
    required this.user,
    required this.message,
    required this.timeSent,
  });

  int user;
  String message;
  DateTime timeSent;

  factory Fields.fromJson(Map<String, dynamic> json) => Fields(
    user: json["user"],
    message: json["message"],
    timeSent: DateTime.parse(json["time_sent"]),
  );

  Map<String, dynamic> toJson() => {
    "user": user,
    "message": message,
    "time_sent": timeSent.toIso8601String(),
  };
}
