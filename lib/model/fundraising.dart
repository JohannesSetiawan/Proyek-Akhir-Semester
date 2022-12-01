// To parse this JSON data, do
//
//     final fundraising = fundraisingFromJson(jsonString);

import 'dart:convert';

List<Fundraising> fundraisingFromJson(String str) => List<Fundraising>.from(json.decode(str).map((x) => Fundraising.fromJson(x)));

String fundraisingToJson(List<Fundraising> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Fundraising {
  Fundraising({
    required this.pk,
    required this.opener,
    required this.name,
    required this.description,
    required this.amountNeeded,
    required this.collectedFunds,
    required this.isVerified,
  });

  int pk;
  String opener;
  String name;
  String description;
  int amountNeeded;
  int collectedFunds;
  bool isVerified;

  factory Fundraising.fromJson(Map<String, dynamic> json) => Fundraising(
    pk: json["pk"],
    opener: json["opener"],
    name: json["name"],
    description: json["description"],
    amountNeeded: json["amountNeeded"],
    collectedFunds: json["collectedFunds"],
    isVerified: json["isVerified"],
  );

  Map<String, dynamic> toJson() => {
    "pk": pk,
    "opener": opener,
    "name": name,
    "description": description,
    "amountNeeded": amountNeeded,
    "collectedFunds": collectedFunds,
    "isVerified": isVerified,
  };
}
