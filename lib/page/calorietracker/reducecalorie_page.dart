import 'package:flutter/material.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:provider/provider.dart';
import '../../model/user_data.dart';


class ReduceCaloriePage extends StatefulWidget {

  final args;

  const ReduceCaloriePage({super.key, required this.args});

  @override
  State<ReduceCaloriePage> createState() => _ReduceCaloriePageState();
}

class _ReduceCaloriePageState extends State<ReduceCaloriePage> {
    final _formKey = GlobalKey<FormState>();
    String calorie = "";
    String description = "";
    String is_increasing = "false";
    String category = "Burn Calorie";
    bool isNumeric(String s) {
        if (s == null) {
            return false;
        }
        return int.tryParse(s) != null;
    }
    void create(request, calorie, description, category, is_increasing) async {
    var response = await request.post('https://nutrious.up.railway.app/calorietracker/calorief/',
        {"calorie" : calorie, "description" : description, "category" :category, "is_increasing" : is_increasing});
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

                //calorie
                Padding(
                  // Menggunakan padding
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    decoration: InputDecoration(
                      labelText: "Calorie",
                      // Menambahkan circular border
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                    ),
                    // Menambahkan behavior saat nama diketik 
                    onChanged: (String? value) {
                        setState(() {
                            calorie = value!;
                        });
                    },
                    // Menambahkan behavior saat data disimpan
                    onSaved: (String? value) {
                        setState(() {
                            calorie = value!;
                        });
                    },
                    // Validator sebagai validasi form
                    validator: (String? value) {
                        if (value == null || value.isEmpty) {
                            return 'Please fill out this part';
                        }else if(isNumeric(value) == false){
                            return 'Input must be in digit';
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
                
                TextButton(
                  child: const Text(
                    "Add Calorie",
                    style: TextStyle(color: Colors.white),
                  ),
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Colors.blue),
                  ),
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      create(request, calorie, description, category, is_increasing);
                        Navigator.of(context).pushReplacementNamed(
                          "/calorietracker_page",
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
              ],
            ),
          ),
        ),
      ),
    );
  }
}
