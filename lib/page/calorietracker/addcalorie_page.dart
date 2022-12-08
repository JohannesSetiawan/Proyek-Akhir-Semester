import 'package:flutter/material.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:provider/provider.dart';
import '../../model/user_data.dart';
import 'package:intl/intl.dart';

class AddCaloriePage extends StatefulWidget {

  // ignore: prefer_typing_uninitialized_variables
  final args;

  const AddCaloriePage({super.key, required this.args});

  @override
  State<AddCaloriePage> createState() => _AddCaloriePageState();
}

class _AddCaloriePageState extends State<AddCaloriePage> {
    final _formKey = GlobalKey<FormState>();
    String calorie = "";
    String description = "";
    String isIncreasing = "true";
   String date = DateFormat("EEEEE, yyyy-MM-dd").format(DateTime.now());
    String time = DateFormat("HH:mm:ss").format(DateTime.now());
    String? category;
    List<String> listCategory= ["Breakfast", "Lunch", "Dinner", "Snack"];
    bool isNumeric(String s) {
        // ignore: unnecessary_null_comparison
        if (s == null) {
            return false;
        }
        return int.tryParse(s) != null;
    }
    void create(request, calorie, description, category, isIncreasing, date, time) async {
    await request.post('https://nutrious.up.railway.app/calorietracker/calorief/',
    {"calorie" : calorie, "description" : description, "category" :category, "is_increasing" : isIncreasing, "date" : date, "time":time});
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
                    minLines: 3,
                    maxLines: 5, 
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
                SizedBox(
                    width: 200,
                    child: DropdownButtonFormField(
                        value: category,
                        isExpanded: true,
                        icon: const Icon(Icons.keyboard_arrow_down),
                        items: listCategory.map((String items) {
                            return DropdownMenuItem(
                                value: items,
                                child: Text(items),
                            );
                        }).toList(),
                        hint: const Text(
                        'Choose a category',
                        ),
                        onChanged: (value) {
                            setState(() {
                            category = value;
                            });
                        },
                        validator: (String? value) {
                            if (value == null || value.isEmpty) {
                                return 'Please choose a category';
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
                      "Add Calorie",
                      style: TextStyle(color: Colors.white),
                    ),
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        create(request, calorie, description, category, isIncreasing, date, time);
                        
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
                 ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}