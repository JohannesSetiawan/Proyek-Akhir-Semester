// ignore_for_file: non_constant_identifier_names

import 'dart:convert';

List<Blog> blogFromJson(String str) =>
    List<Blog>.from(json.decode(str).map((x) => Blog.fromJson(x)));

String blogToJson(List<Blog> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Blog {
  Blog({
    required this.pk,
    required this.title,
    required this.author,
    required this.content,
    required this.created_on,
    required this.upvote,
    required this.downvote,
    required this.vote_state,
    required this.tag,
  });

  int pk;
  String title;
  String author;
  String content;
  String created_on;
  int upvote;
  int downvote;
  int vote_state;
  String tag;

  factory Blog.fromJson(Map<String, dynamic> json) => Blog(
      pk: json["pk"],
      title: json["fields"]["title"],
      author: json["fields"]["author"],
      content: json["fields"]["content"],
      created_on: json["fields"]["created_on"],
      upvote: json["fields"]["upvote"],
      downvote: json["fields"]["downvote"],
      vote_state: json["fields"]["vote_state"],
      tag: json["fields"]["tag"]);

  // factory Blog.fromJsonTag(Map<String, dynamic> json) => Blog(
  //     tag: json["tag"]
  // );

  Map<String, dynamic> toJson() => {
        "pk": pk,
        "title": title,
        "author": author,
        "content": content,
        "created_on": created_on,
        "upvote": upvote,
        "downvote": downvote,
        "vote_state": vote_state,
        "tag": tag,
      };
}
