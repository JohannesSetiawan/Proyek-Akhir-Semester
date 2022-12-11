import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:provider/provider.dart';
import '../../model/user_data.dart';


class AddFoodsharingPage extends StatefulWidget {

  // ignore: prefer_typing_uninitialized_variables
  final args;

  const AddFoodsharingPage({super.key, required this.args});

  @override
  State<AddFoodsharingPage> createState() => _AddFoodsharingPageState();
}

class _AddFoodsharingPageState extends State<AddFoodsharingPage> {
    final _formKey = GlobalKey<FormState>();
    String location = "";
    String description = "";
    String img = "";

    String date = DateFormat('dd-MM-yyyy hh:mm:ss').format(DateTime.now());
    String updateDate = DateFormat('dd-MM-yyyy hh:mm:ss').format(DateTime.now());
 
    void create(request, location, description, img, date, updateDate) async {
    // ignore: unused_local_variable
    var response = await request.post('https://nutrious.up.railway.app/foodsharing/foodsharingf',
        {"location" : location, "description" : description, "img" :img, "date":date, "update_date":updateDate});
    }

  @override
  Widget build(BuildContext context) {
    final request = context.watch<CookieRequest>();
    final args = widget.args;
    return Scaffold(
      appBar: AppBar(
          backgroundColor: const Color(0xFFF0FFFF),
          centerTitle: true,
          title: Image.asset('images/NUTRIOUS.png', height: 75),
          toolbarHeight: 100,
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(
                  bottom: Radius.circular(30)
              )
          ),
          iconTheme: const IconThemeData(color: Colors.indigo)
      ),
    body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [

                Padding(
                  // Menggunakan padding
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    decoration: InputDecoration(
                      labelText: "URL Image",
                      // Menambahkan circular border
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                    ),
                    // Menambahkan behavior saat nama diketik 
                    onChanged: (String? value) {
                        setState(() {
                            img = value!;
                        });
                    },
                    // Menambahkan behavior saat data disimpan
                    onSaved: (String? value) {
                        setState(() {
                            img = value!;
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

                Padding(
                  // Menggunakan padding
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    decoration: InputDecoration(
                      labelText: "Location",
                      // Menambahkan circular border
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                    ),
                    // Menambahkan behavior saat nama diketik 
                    onChanged: (String? value) {
                        setState(() {
                            location = value!;
                        });
                    },
                    // Menambahkan behavior saat data disimpan
                    onSaved: (String? value) {
                        setState(() {
                            location = value!;
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

                // description
                Padding(
                  // Menggunakan padding
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    decoration: InputDecoration(
                      labelText: "Description",
                      // Menambahkan circular border
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                    ),
                    minLines: 3,
                    keyboardType: TextInputType.multiline,
                    maxLines: null,

                    // Menambahkan behavior saat kolom description diisi
                    onChanged: (String? value) {
                      setState(() {
                        description = value!;
                      });
                    },
                    // Menambahkan behavior saat data disimpan
                    onSaved: (String? value) {
                      setState(() {
                        description = value!;
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
              

                
                Padding(padding: const EdgeInsets.all(10.0),
                  child: TextButton(
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(Colors.blue),
                    ),
                    child: const Text(
                      "Add Post",
                      style: TextStyle(color: Colors.white),
                    ),
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        create(request, location, description, img, date, updateDate);
                        
                          Navigator.of(context).pushReplacementNamed(
                            "/foodsharing_page",
                            arguments: UserArguments(
                                args.isAdmin,
                                args.username,
                                args.nickname,
                                args.desc,
                                args.profURL,
                                args.isVerified
                            )
                        );
                      }
                    },
                  ),
                 ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
