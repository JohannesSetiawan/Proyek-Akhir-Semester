import 'package:flutter/material.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:provider/provider.dart';
import '../../model/user_data.dart';
import 'package:nutrious/page/blog/show_tag.dart';
import 'package:convex_bottom_bar/convex_bottom_bar.dart';

class CreatePost extends StatefulWidget {
  // ignore: prefer_typing_uninitialized_variables
  final args;

  const CreatePost({super.key, required this.args});

  @override
  State<CreatePost> createState() => _CreatePostState();
}

class _CreatePostState extends State<CreatePost> {
  final _formKey = GlobalKey<FormState>();
  String title = "";
  String tag = "";
  String content = "";

  void create(request, title, tag, content) async {
    await request.post('https://nutrious.up.railway.app/blog/add-post-flutter/',
        {"title": title, "tag": tag, "content": content});
  }

  @override
  Widget build(BuildContext context) {
    final request = context.watch<CookieRequest>();
    final args = widget.args;
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
        body: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Container(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: [
                  // Title
                  Padding(
                    // Menggunakan padding
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      decoration: InputDecoration(
                        hintText: "Example: Makanan 4 sehat 5 sempurna",
                        labelText: "Judul Post",
                        // Menambahkan icon
                        icon: const Icon(Icons.title),
                        // Menambahkan circular border
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5.0),
                        ),
                      ),
                      // Menambahkan behavior saat kolom judul diisi
                      onChanged: (String? value) {
                        setState(() {
                          title = value!;
                        });
                      },
                      // Menambahkan behavior saat data disimpan
                      onSaved: (String? value) {
                        setState(() {
                          title = value!;
                        });
                      },
                      // Validator sebagai validasi form
                      validator: (String? value) {
                        if (value == null || value.isEmpty) {
                          return 'Kamu lupa memberikan judul dari post kamu nih';
                        }
                        return null;
                      },
                    ),
                  ),

                  // Tag
                  Padding(
                    // Menggunakan padding
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      decoration: InputDecoration(
                        labelText: "Tag",
                        // Menambahkan icon
                        icon: const Icon(Icons.title),
                        // Menambahkan circular border
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5.0),
                        ),
                      ),
                      // Menambahkan behavior saat kolom judul diisi
                      onChanged: (String? value) {
                        setState(() {
                          tag = value!;
                        });
                      },
                      // Menambahkan behavior saat data disimpan
                      onSaved: (String? value) {
                        setState(() {
                          tag = value!;
                        });
                      },
                      // Validator sebagai validasi form
                      validator: (String? value) {
                        if (value == null || value.isEmpty) {
                          return 'Please fill out this part';
                        }
                        return null;
                      },
                    ),
                  ),

                  // Content
                  Padding(
                    // Menggunakan padding
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      maxLines: null,
                      keyboardType: TextInputType.multiline,
                      decoration: InputDecoration(
                        hintText: "Beberapa makanan ini akan membuatmu...",
                        labelText: "Content",
                        // Menambahkan icon
                        icon:
                            const Icon(Icons.drive_file_rename_outline_rounded),
                        // Menambahkan circular border
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5.0),
                        ),
                      ),

                      // Menambahkan behavior saat kolom nominal diisi
                      onChanged: (String? value) {
                        setState(() {
                          content = value!;
                        });
                      },
                      // Menambahkan behavior saat data disimpan
                      onSaved: (String? value) {
                        setState(() {
                          content = value!;
                        });
                      },
                      // Validator sebagai validasi form
                      validator: (String? value) {
                        // Saat kosong
                        if (value == null || value.isEmpty) {
                          return 'Please fill out this part';
                        }
                        return null;
                      },
                    ),
                  ),

                  TextButton(
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(Colors.blue),
                    ),
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        create(request, title, tag, content);
                        Navigator.of(context).pushReplacementNamed("/blog_list",
                            arguments: UserArguments(
                                args.isAdmin,
                                args.username,
                                args.nickname,
                                args.desc,
                                args.profURL,
                                args.isVerified));
                      }
                    },
                    child: const Text(
                      "Create",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        bottomNavigationBar: ConvexAppBar(
            initialActiveIndex: 1,
            backgroundColor: const Color(0xff59A5D8),
            items: const [
              TabItem(icon: Icons.home, title: 'Home'),
              TabItem(
                  icon: Icons.drive_file_rename_outline_rounded,
                  title: 'Write'),
              TabItem(icon: Icons.search, title: 'Search'),
            ],
            onTap: (int i) => (i == 1
                // ignore: avoid_print
                ? print("")
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
