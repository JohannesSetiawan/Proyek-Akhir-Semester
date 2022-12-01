// To parse this JSON data, do
//
//     final user = userFromJson(jsonString);

import 'dart:convert';

List<User> userFromJson(String str) => List<User>.from(json.decode(str).map((x) => User.fromJson(x)));

String userToJson(List<User> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class User {
  User({
    required this.model,
    required this.pk,
    required this.fields,
  });

  Model? model;
  int pk;
  Fields fields;

  factory User.fromJson(Map<String, dynamic> json) => User(
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
    required this.password,
    required this.lastLogin,
    required this.isSuperuser,
    required this.username,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.isStaff,
    required this.isActive,
    required this.dateJoined,
    required this.nickname,
    required this.description,
    required this.profilePictUrl,
    required this.isAdmin,
    required this.isVerifiedUser,
    required this.isUser,
    required this.groups,
    required this.userPermissions,
    required this.post,
  });

  String password;
  DateTime lastLogin;
  bool isSuperuser;
  String username;
  String firstName;
  String lastName;
  String email;
  bool isStaff;
  bool isActive;
  DateTime dateJoined;
  String nickname;
  String description;
  String profilePictUrl;
  bool isAdmin;
  bool isVerifiedUser;
  bool isUser;
  List<dynamic> groups;
  List<dynamic> userPermissions;
  List<int> post;

  factory Fields.fromJson(Map<String, dynamic> json) => Fields(
    password: json["password"],
    lastLogin: DateTime.parse(json["last_login"]),
    isSuperuser: json["is_superuser"],
    username: json["username"],
    firstName: json["first_name"],
    lastName: json["last_name"],
    email: json["email"],
    isStaff: json["is_staff"],
    isActive: json["is_active"],
    dateJoined: DateTime.parse(json["date_joined"]),
    nickname: json["nickname"],
    description: json["description"],
    profilePictUrl: json["profile_pict_url"],
    isAdmin: json["is_admin"],
    isVerifiedUser: json["is_verified_user"],
    isUser: json["is_user"],
    groups: List<dynamic>.from(json["groups"].map((x) => x)),
    userPermissions: List<dynamic>.from(json["user_permissions"].map((x) => x)),
    post: List<int>.from(json["post"].map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "password": password,
    "last_login": lastLogin.toIso8601String(),
    "is_superuser": isSuperuser,
    "username": username,
    "first_name": firstName,
    "last_name": lastName,
    "email": email,
    "is_staff": isStaff,
    "is_active": isActive,
    "date_joined": dateJoined.toIso8601String(),
    "nickname": nickname,
    "description": description,
    "profile_pict_url": profilePictUrl,
    "is_admin": isAdmin,
    "is_verified_user": isVerifiedUser,
    "is_user": isUser,
    "groups": List<dynamic>.from(groups.map((x) => x)),
    "user_permissions": List<dynamic>.from(userPermissions.map((x) => x)),
    "post": List<dynamic>.from(post.map((x) => x)),
  };
}

enum Model { HOME_APPUSER }

final modelValues = EnumValues({
  "home.appuser": Model.HOME_APPUSER
});

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    if (reverseMap == null) {
      reverseMap = map.map((k, v) => new MapEntry(v, k));
    }
    return reverseMap;
  }
}
