import 'package:flutter/material.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:provider/provider.dart';
import 'package:nutrious/model/blog.dart';
import 'package:nutrious/page/blog/blog_details.dart';
import 'package:nutrious/page/blog/show_tag.dart';
import 'package:nutrious/page/blog/create_blog.dart';
import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import '../../model/user_data.dart';

class TagPage extends StatefulWidget {
  // ignore: prefer_typing_uninitialized_variables
  final tag;
  // ignore: prefer_typing_uninitialized_variables
  final args;
  const TagPage({super.key, required this.tag, required this.args});

  @override
  State<TagPage> createState() => _TagPageState();
}

class _TagPageState extends State<TagPage> {
  // Future future = fetchBlog();

  String substringContent(String content) {
    return content.substring(0, 200);
  }

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
    final tag = widget.tag;
    final args = widget.args;

    // queryTag(request, tag);

    Future<List<Blog>> fetchBlogTag() async {
      final response = await request
          .get("https://nutrious.up.railway.app/blog/show-tag-flutter/$tag");
      List<Blog> listBlog = [];
      for (var post in response["data"]) {
        if (post != null) {
          listBlog.add(Blog.fromJson(post));
        }
      }
      return listBlog;
    }

    return Scaffold(
        appBar: AppBar(
            backgroundColor: const Color(0xFFF0FFFF),
            // backgroundColor: const Color(0xFFF0FFFF),
            centerTitle: true,
            title: Image.asset('images/NUTRIOUS.png', height: 75),
            toolbarHeight: 100,
            shape: const RoundedRectangleBorder(
                borderRadius:
                    BorderRadius.vertical(bottom: Radius.circular(30))),
            iconTheme: const IconThemeData(color: Colors.indigo)),
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
                        "Tidak ada blog :(",
                        style:
                            TextStyle(color: Color(0xff59A5D8), fontSize: 20),
                      ),
                      SizedBox(height: 8),
                    ],
                  );
                } else {
                  return ListView.builder(
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
                                    offset: const Offset(
                                      1.0, // Move to right 10  horizontally
                                      1.0, // Move to bottom 10 Vertically
                                    ),
                                  )
                                ],
                              ),
                              child: Card(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(
                                          15), // if you need this
                                      side: const BorderSide(
                                        color: Colors.green,
                                        width: 2,
                                      )),
                                  child: Container(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 4, vertical: 18),
                                      child: Column(children: [
                                        ListTile(
                                          title: Text(
                                            "${snapshot.data![index].title}",
                                            style: const TextStyle(
                                              fontSize: 18.0,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                        Row(children: [
                                          const SizedBox(width: 15),
                                          Text(
                                              "${snapshot.data![index].created_on}"),
                                          Text(
                                              "  |  ${snapshot.data![index].author}"),
                                        ]),
                                        const SizedBox(height: 10),
                                        Align(
                                          alignment: Alignment.centerLeft,
                                          child: Row(children: [
                                            const SizedBox(width: 15),
                                            Flexible(
                                              child: Text(
                                                  "${snapshot.data![index].content.length > 200 ? substringContent(snapshot.data![index].content) : snapshot.data![index].content}..."),
                                            ),
                                            const SizedBox(width: 15),
                                          ]),
                                        ),
                                        const SizedBox(height: 20),
                                        Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceAround,
                                            children: [
                                              Ink(
                                                decoration: BoxDecoration(
                                                  color: Colors.green,
                                                  borderRadius:
                                                      BorderRadius.circular(14),
                                                ),
                                                child: InkWell(
                                                  borderRadius:
                                                      BorderRadius.circular(24),
                                                  onTap: () {
                                                    Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                          builder: (context) =>
                                                              BlogListDetail(
                                                                  blogList: snapshot
                                                                          .data![
                                                                      index],
                                                                  args: args)),
                                                    );
                                                  },
                                                  child: Container(
                                                    width: 80.0,
                                                    height: 30.0,
                                                    alignment: Alignment.center,
                                                    child: const Text(
                                                      'Read More',
                                                      style: TextStyle(
                                                          color: Colors.white,
                                                          fontSize: 10),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              Row(children: [
                                                IconButton(
                                                  icon: const Icon(
                                                      Icons
                                                          .thumb_up_alt_rounded,
                                                      color: Colors.blue),
                                                  onPressed: () {
                                                    setState(() {
                                                      upvote(
                                                          request,
                                                          snapshot
                                                              .data![index].pk);
                                                      // snapshot.data![index].upvote++;
                                                    });
                                                  },
                                                ),
                                                Text(
                                                    "${snapshot.data![index].upvote}"),
                                                IconButton(
                                                  icon: const Icon(
                                                      Icons
                                                          .thumb_down_alt_rounded,
                                                      color: Colors.red),
                                                  onPressed: () {
                                                    setState(() {
                                                      downvote(
                                                          request,
                                                          snapshot
                                                              .data![index].pk);
                                                      // snapshot.data![index].downvote++;
                                                    });
                                                  },
                                                ),
                                                Text(
                                                    "${snapshot.data![index].downvote}"),
                                              ])
                                            ])
                                      ]))))));
                }
              }
            }),
        bottomNavigationBar: ConvexAppBar(
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
                    ? Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => TagList(args: args)))
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
