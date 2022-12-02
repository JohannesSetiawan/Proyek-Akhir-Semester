// To parse this JSON data, do
//
//     final message = messageFromJson(jsonString);

import 'dart:convert';

List<Message> messageFromJson(String str) => List<Message>.from(json.decode(str).map((x) => Message.fromJson(x)));

String messageToJson(List<Message> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Message {
  Message({
    required this.pk,
    required this.sender,
    required this.message,
    required this.time,
  });

  int pk;
  String sender;
  String message;
  DateTime time;

  factory Message.fromJson(Map<String, dynamic> json) => Message(
    pk: json["pk"],
    sender: json["sender"],
    message: json["message"],
    time: DateTime.parse(json["time"]),
  );

  Map<String, dynamic> toJson() => {
    "pk": pk,
    "sender": sender,
    "message": message,
    "time": time.toIso8601String(),
  };
}
