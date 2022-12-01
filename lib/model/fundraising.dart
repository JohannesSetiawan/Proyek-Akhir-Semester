// To parse this JSON data, do
//
//     final fundraising = fundraisingFromJson(jsonString);

import 'dart:convert';

List<Fundraising> fundraisingFromJson(String str) => List<Fundraising>.from(json.decode(str).map((x) => Fundraising.fromJson(x)));

String fundraisingToJson(List<Fundraising> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Fundraising {
  Fundraising({
    required this.model,
    required this.pk,
    required this.fields,
  });

  String model;
  int pk;
  Fields fields;

  factory Fundraising.fromJson(Map<String, dynamic> json) => Fundraising(
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
    required this.name,
    required this.opener,
    required this.description,
    required this.amountNeeded,
    required this.collectedFunds,
    required this.isVerified,
  });

  String name;
  int opener;
  String description;
  int amountNeeded;
  int collectedFunds;
  bool isVerified;

  factory Fields.fromJson(Map<String, dynamic> json) => Fields(
    name: json["name"],
    opener: json["opener"],
    description: json["description"],
    amountNeeded: json["amountNeeded"],
    collectedFunds: json["collectedFunds"],
    isVerified: json["is_verified"],
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "opener": opener,
    "description": description,
    "amountNeeded": amountNeeded,
    "collectedFunds": collectedFunds,
    "is_verified": isVerified,
  };
}
