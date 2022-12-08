import 'package:flutter/material.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:provider/provider.dart';
import '../../model/user_data.dart';
import 'package:nutrious/model/calorie.dart';

class EditAddCaloriePage extends StatefulWidget {
 
  final Calorie mycalorie;
  // ignore: prefer_typing_uninitialized_variables
  final args;
  

  const EditAddCaloriePage({super.key, required this.mycalorie, required this.args});
  @override
  State<EditAddCaloriePage> createState() => _EditAddCaloriePageState();
}

class _EditAddCaloriePageState extends State<EditAddCaloriePage> {

    final _formKey = GlobalKey<FormState>();
    String calorie ="";
    String description ="";
    String? category;
    TextEditingController? txtcalorie, txtdescription;
    setup(){
        txtcalorie = TextEditingController(text: widget.mycalorie.calorie.toString());
        txtdescription = TextEditingController(text: widget.mycalorie.description);
    }
   
    List<String> listCategory= ["Breakfast", "Lunch", "Dinner", "Snack"];
    bool isNumeric(String s) {
        // ignore: unnecessary_null_comparison
        if (s == null) {
            return false;
        }
        return int.tryParse(s) != null;
    }
      @override
    void initState(){
        super.initState();
        setup();
    }
    
    void editAddSavef(request, id, calorie, description, category) async {
        String pk = id.toString();
        if(calorie==""){
            calorie= widget.mycalorie.calorie.toString();
        }
        if(description==""){
            description=widget.mycalorie.description;
        }
        category ??= widget.mycalorie.category;
    await request.post('https://nutrious.up.railway.app/calorietracker/edit_add_savef/',
        {"id" : pk, "calorie" : calorie, "description" : description, "category" :category});
  }
  @override
  Widget build(BuildContext context) {
    final request = context.watch<CookieRequest>();
    final argscal = widget.mycalorie;
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
                    controller: txtcalorie,
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
                    controller: txtdescription,
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
                        value: argscal.category,
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
                        onChanged: (String? newValue) {
                            setState(() {
                            category = newValue!;
                            });
                        },
                        validator: (String? newValue) {
                            if (newValue == null || newValue.isEmpty) {
                                return 'Please choose a category';
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
                      editAddSavef(request,argscal.pk, calorie, description, category);
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