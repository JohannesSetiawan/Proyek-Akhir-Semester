import 'package:flutter/material.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:provider/provider.dart';
import '../../model/user_data.dart';

class OpenDonation extends StatefulWidget {
  final dynamic args;

  const OpenDonation({super.key, required this.args});

  @override
  State<OpenDonation> createState() => _OpenDonationState();
}

class _OpenDonationState extends State<OpenDonation> {
  final _formKey = GlobalKey<FormState>();
  String name = "";
  String description = "";
  String amountNeeded = "";

  bool isNumeric(String value){
    return int.tryParse(value) != null;
  }

  create(request, name, description, amountNeeded) async {
    var response = await request.post('https://nutrious.up.railway.app/donation/add-donatee/',
        {"name" : name, "description" : description, "amountNeeded" : amountNeeded});
    return response;
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

                // name
                Padding(
                  // Menggunakan padding
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    decoration: InputDecoration(
                      hintText: "Example: Putra",
                      labelText: "Title/Donatee Name",
                      // Menambahkan icon
                      icon: const Icon(Icons.title),
                      // Menambahkan circular border
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                    ),
                    // Menambahkan behavior saat kolom name diisi
                    onChanged: (String? value) {
                      setState(() {
                        name = value!;
                      });
                    },
                    // Menambahkan behavior saat data disimpan
                    onSaved: (String? value) {
                      setState(() {
                        name = value!;
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
                      labelText: "Donatee Description",
                      // Menambahkan icon
                      icon: const Icon(Icons.title),
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

                // amountNeeded
                Padding(
                  // Menggunakan padding
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    decoration: InputDecoration(
                      hintText: "Minimum: 100000",
                      labelText: "Amount Needed",
                      // Menambahkan icon
                      icon: const Icon(Icons.attach_money),
                      // Menambahkan circular border
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                    ),

                    keyboardType: TextInputType. number,

                    // Menambahkan behavior saat kolom nominal diisi
                    onChanged: (String? value) {
                      setState(() {
                        amountNeeded = value!;
                      });
                    },
                    // Menambahkan behavior saat data disimpan
                    onSaved: (String? value) {
                      setState(() {
                        amountNeeded = value!;
                      });
                    },
                    // Validator sebagai validasi form
                    validator: (String? value) {

                      // Saat kosong
                      if (value == null || value.isEmpty) {
                        return 'Please fill out this part';
                      }

                      // Saat bukan angka
                      if (!isNumeric(value)) {
                        return 'Please fill this part with integer';
                      }

                      // Saat amountNeeded yang dimasukkan kurang dari 100000
                      if (int.tryParse(value)! < 100000) {
                        return 'Amount needed must be greater than or equal 100000';
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
                      create(request, name, description, amountNeeded);
                      Navigator.of(context).pushReplacementNamed(
                          "/donation_list",
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
                  child: const Text(
                    "Open",
                    style: TextStyle(color: Colors.white),
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
