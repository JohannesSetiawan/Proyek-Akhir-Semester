import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:nutrious/model/blog.dart';

Future<List<Blog>> fetchBlog() async {
  var url =
  Uri.parse('https://nutrious.up.railway.app/blog/json/');
  var response = await http.get(
    url,
    headers: {
      "Access-Control-Allow-Origin": "*",
      "Content-Type": "application/json",
    },
  );

// check dimana
  // melakukan decode response menjadi bentuk json
  var data = jsonDecode(utf8.decode(response.bodyBytes));

  // melakukan konversi data json menjadi object
  List<Blog> listBlog = [];
  for (var d in data) {
    if (d != null) {
      listBlog.add(Blog.fromJson(d));
    }
  }

  return listBlog;
}