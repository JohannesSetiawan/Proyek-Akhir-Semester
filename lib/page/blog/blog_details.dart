import 'package:flutter/material.dart';
// import 'package:counter_7/page/drawer.dart';
import 'package:nutrious/model/blog.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:provider/provider.dart';

class BlogListDetail extends StatefulWidget {
  final Blog blogList;
  // ignore: prefer_typing_uninitialized_variables
  final args;
  const BlogListDetail({super.key, required this.blogList, required this.args});

  @override
  State<BlogListDetail> createState() => _BlogListDetailState();
}

class _BlogListDetailState extends State<BlogListDetail> {
  void upvote(request, pk) async {
    await request.get('https://nutrious.up.railway.app/blog/updateUpvote/$pk');
  }

  void downvote(request, pk) async {
    await request
        .get('https://nutrious.up.railway.app/blog/updateDownvote/$pk');
  }

  @override
  Widget build(BuildContext context) {
    final request = context.watch<CookieRequest>();
    final blogList = widget.blogList;
    return Scaffold(
        appBar: AppBar(
            backgroundColor: const Color(0xFFF0FFFF),
            centerTitle: true,
            title: Image.asset('images/NUTRIOUS.png', height: 75),
            toolbarHeight: 100,
            shape: const RoundedRectangleBorder(
                borderRadius:
                    BorderRadius.vertical(bottom: Radius.circular(30))),
            iconTheme: const IconThemeData(color: Colors.indigo)),
        // drawer: createDrawer(context),
        body: SingleChildScrollView(
            child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
          child: Column(children: [
            Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Flexible(
                      child: Align(
                          alignment: Alignment.centerLeft,
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  blogList.title,
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 30),
                                  textAlign: TextAlign.start,
                                ),
                                Text(
                                  blogList.created_on,
                                  style: const TextStyle(fontSize: 18),
                                ),
                                Text(
                                  blogList.author,
                                  style: const TextStyle(fontSize: 18),
                                )
                              ]))),
                  Container(
                      margin: const EdgeInsets.only(right: 20.0),
                      child: Row(children: [
                        IconButton(
                          icon: const Icon(Icons.thumb_up_alt_rounded,
                              color: Colors.blue),
                          onPressed: () {
                            setState(() {
                              upvote(request, blogList.pk);
                              // snapshot.data![index].upvote++;
                            });
                          },
                        ),
                        Text("${blogList.upvote}"),
                        IconButton(
                          icon: const Icon(Icons.thumb_down_alt_rounded,
                              color: Colors.red),
                          onPressed: () {
                            setState(() {
                              downvote(request, blogList.pk);
                              // snapshot.data![index].downvote++;
                            });
                          },
                        ),
                        Text("${blogList.downvote}"),
                      ])),
                ]),
            Column(
              children: [
                const SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    Flexible(
                        child: Text(
                      blogList.content,
                      style: const TextStyle(fontSize: 18),
                    ))
                  ],
                )
              ],
            ),
          ]),
        )));
  }
}
