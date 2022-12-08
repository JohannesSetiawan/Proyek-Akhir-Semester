import 'package:flutter/material.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:provider/provider.dart';
import 'package:nutrious/page/blog/create_blog.dart';
import 'package:nutrious/page/blog/tag_page.dart';
import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import '../../model/user_data.dart';

class TagList extends StatefulWidget {
  // ignore: prefer_typing_uninitialized_variables
  final args;
  const TagList({super.key, required this.args});

  @override
  State<TagList> createState() => _TagListState();
}

class _TagListState extends State<TagList> {
  String substringContent(String content) {
    return content.substring(0, 200);
  }

  List splitTag(String tag) {
    //split string
    var arr = tag.split(' ');
    return arr;
  }

  @override
  Widget build(BuildContext context) {
    final request = context.watch<CookieRequest>();
    final args = widget.args;

    Future<List<String>> fetchBlogTag() async {
      final response =
          await request.get("https://nutrious.up.railway.app/blog/jsontag/");
      List<String> listTag = [];
      for (var post in response["taglist"]) {
        if (post != null) {
          listTag.add(post);
        }
      }
      return listTag;
    }

    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: const Color(0xFFF0FFFF),
          centerTitle: true,
          title: Image.asset('images/NUTRIOUS.png', height: 75),
          toolbarHeight: 100,
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(bottom: Radius.circular(30))),
        ),
        body: FutureBuilder(
            future: fetchBlogTag(),
            builder: (context, AsyncSnapshot snapshot) {
              if (snapshot.data == null) {
                return const Center(child: CircularProgressIndicator());
              } else {
                if (!snapshot.hasData) {
                  return Column(
                    children: const [
                      Text(
                        "Tidak ada tag :(",
                        style:
                            TextStyle(color: Color(0xff59A5D8), fontSize: 20),
                      ),
                      SizedBox(height: 8),
                    ],
                  );
                } else {
                  return SingleChildScrollView(
                    physics: const ScrollPhysics(),
                    child: Column(
                      children: <Widget>[
                        const SizedBox(height: 30),
                        Text('Available Post',
                            style: TextStyle(
                                fontSize: 30,
                                fontWeight: FontWeight.bold,
                                shadows: [
                                  Shadow(
                                    offset: const Offset(
                                        2.0, 2.0), //position of shadow
                                    blurRadius: 2.0, //blur intensity of shadow
                                    color: Colors.grey.withOpacity(
                                        0.5), //color of shadow with opacity
                                  ),
                                ])),
                        const SizedBox(height: 30),
                        ListView.builder(
                            physics: const NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: snapshot.data!.length,
                            itemBuilder: (_, index) => SingleChildScrollView(
                                    child: Container(
                                  margin: const EdgeInsets.symmetric(
                                      horizontal: 6, vertical: 1),
                                  decoration: BoxDecoration(
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey.withOpacity(.5),
                                        blurRadius: 20.0, // soften the shadow
                                        spreadRadius: 5.0, //extend the shadow
                                        offset: const Offset(1.0, 1.0),
                                      )
                                    ],
                                  ),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      for (var item
                                          in splitTag(snapshot.data![index]))
                                        SizedBox(
                                          width: double.infinity,
                                          height: 50,
                                          child: Card(
                                            child: InkWell(
                                                onTap: () {
                                                  Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            TagPage(
                                                                tag: item,
                                                                args: args)),
                                                  );
                                                },
                                                child: Column(children: [
                                                  const SizedBox(height: 11),
                                                  Text(item),
                                                ])),
                                          ),
                                        )
                                    ],
                                  ),
                                )))
                      ],
                    ),
                  );
                  // return Column(
                  //   children:[
                  //     Text("Test"),
                  //     ListView.builder(
                  // itemCount: snapshot.data!.length,
                  // itemBuilder: (_, index) => SingleChildScrollView(
                  //   child: Container(
                  //     margin: const EdgeInsets.symmetric(horizontal: 6, vertical: 1),
                  //     decoration: BoxDecoration(
                  //       boxShadow: [
                  //         BoxShadow(color: Colors.grey.withOpacity(.5),
                  //           blurRadius: 20.0, // soften the shadow
                  //           spreadRadius: 5.0, //extend the shadow
                  //           offset: const Offset(1.0, 1.0),
                  //         )
                  //       ],
                  //     ),
                  //     child: Column(
                  //       mainAxisAlignment: MainAxisAlignment.center,
                  //       children: <Widget>[
                  //         for(var item in splitTag(snapshot.data![index].tag))
                  //         SizedBox(width: double.infinity, height: 50,
                  //           child: Card(
                  //             child: Column(
                  //               children:[
                  //                 SizedBox(height:11),
                  //                 Text(item),
                  //               ]
                  //             )
                  //           ),
                  //         )
                  //       ],
                  //     ),
                  //   )
                  // )
                  //     )
                  //   ]
                  // );
                }
              }
            }),
        bottomNavigationBar: ConvexAppBar(
            initialActiveIndex: 2,
            backgroundColor: const Color(0xff59A5D8),
            items: const [
              TabItem(icon: Icons.home, title: 'Home'),
              TabItem(
                  icon: Icons.drive_file_rename_outline_rounded,
                  title: 'Write'),
              TabItem(icon: Icons.search, title: 'Search'),
            ],
            onTap: (int i) => (i == 1
                ? Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => CreatePost(args: args)))
                : (i == 2
                    // ignore: avoid_print
                    ? print("")
                    : Navigator.of(context).pushReplacementNamed("/blog_list",
                        arguments: UserArguments(
                            args.isAdmin,
                            args.username,
                            args.nickname,
                            args.desc,
                            args.profURL,
                            args.isVerified))))));
  }
}
