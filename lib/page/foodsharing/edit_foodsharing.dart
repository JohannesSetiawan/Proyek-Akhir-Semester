import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:provider/provider.dart';
import '../../model/user_data.dart';
import 'package:nutrious/model/foodsharing.dart';

class EditFoodsharingPage extends StatefulWidget {
  final Foodsharing mypost;
  // ignore: prefer_typing_uninitialized_variables
  final args;

  const EditFoodsharingPage(
      {super.key, required this.mypost, required this.args});
  @override
  State<EditFoodsharingPage> createState() => _EditFoodsharingPageState();
}

class _EditFoodsharingPageState extends State<EditFoodsharingPage> {
  final _formKey = GlobalKey<FormState>();
  String img = "";
  String location = "";
  String description = "";
  TextEditingController? txtimg, txtlocation, txtdescription;
  setup() {
    txtimg = TextEditingController(text: widget.mypost.img);
    txtlocation = TextEditingController(text: widget.mypost.location);
    txtdescription = TextEditingController(text: widget.mypost.description);
  }
  @override
  void initState(){
      super.initState();
      setup();
 }
  void editAddSavef(request, id, img, location, description) async {
    String pk = id.toString();
    if (img == "") {
      img = widget.mypost.img;
    }
    if (location == "") {
      location = widget.mypost.location;
    }
    if (description == "") {
      description = widget.mypost.description;
    }
   
    String updateDate = DateFormat('dd-MM-yyyy hh:mm:ss').format(DateTime.now());
    await request.post(
      'https://nutrious.up.railway.app/foodsharing/edit_add_savef', {
      "id": pk,
      "img": img,
      "location": location,
      "description": description,
     
      "update_date":updateDate,
    });
  }

  @override
  Widget build(BuildContext context) {
    final request = context.watch<CookieRequest>();
    final argscal = widget.mypost;
    final args = widget.args;
    return Scaffold(
      appBar: AppBar(
          backgroundColor: const Color(0xFFF0FFFF),
          centerTitle: true,
          title: Image.asset('images/NUTRIOUS.png', height: 75),
          toolbarHeight: 100,
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(bottom: Radius.circular(30))),
          iconTheme: const IconThemeData(color: Colors.indigo)),
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
                    controller: txtimg,
                    decoration: InputDecoration(
                      labelText: "URL Image",
                      // Menambahkan circular border
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                    ),

                    // Menambahkan behavior saat kolom description diisi
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
                
                //location
                Padding(
                  // Menggunakan padding
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    controller: txtlocation,
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
                    controller: txtdescription,
                    minLines: 3,
                    maxLines: null,
                    keyboardType: TextInputType.multiline,
                    decoration: InputDecoration(
                      labelText: "Description",
                      // Menambahkan circular border
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                    ),

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

                TextButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Colors.blue),
                  ),
                  child: const Text(
                    "Edit",
                    style: TextStyle(color: Colors.white),
                  ),
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      editAddSavef(
                          request, argscal.pk, img, location, description);
                      Navigator.of(context).pushReplacementNamed(
                          "/foodsharing_page",
                          arguments: UserArguments(
                              args.isAdmin,
                              args.username,
                              args.nickname,
                              args.desc,
                              args.profURL,
                              args.isVerified));
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
