import 'package:flutter/material.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:provider/provider.dart';

// import '../../model/user_data.dart';
// import '../../model/foodrecipe.dart';
import '../home/drawer.dart';
// import 'recipe_page.dart';

class AddRecipe extends StatefulWidget {
  // ignore: prefer_typing_uninitialized_variables
  final args;

  const AddRecipe({super.key, required this.args});

  @override
  State<AddRecipe> createState() => _AddRecipeState();
}

class _AddRecipeState extends State<AddRecipe> {
  final _formKey = GlobalKey<FormState>();
  String foodName = "";
  String ingredients = "";
  String method = "";

  void add(request, foodName, ingredients, method) async {
    await request.post('https://nutrious.up.railway.app/recipe/add-flutter/',
        {"food_name": foodName, "ingredients": ingredients, "method": method});
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
            borderRadius: BorderRadius.vertical(bottom: Radius.circular(30))),
        iconTheme: const IconThemeData(color: Colors.indigo),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      drawer: DrawerMenu(
        isAdmin: args.isAdmin,
        username: args.username,
        description: args.desc,
        nickname: args.nickname,
        profileURL: args.profURL,
        isVerified: args.isVerified,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            const Align(
              alignment: Alignment.topCenter,
              child: Text("Add your recipe!",
                  style: TextStyle(
                    color: Colors.black,
                    fontFamily: 'Poppins',
                    fontSize: 20,
                  )),
            ),
            const SizedBox(
              height: 20,
            ),

            
            Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[

                  // Food Name
                  TextFormField(
                    decoration: const InputDecoration(
                        labelText: 'Food Name',
                        hintText: 'What is your food called?',
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(20.0)),
                          borderSide:
                              BorderSide(color: Colors.grey, width: 0.0),
                        ),
                        border: OutlineInputBorder()),
                    onSaved: (String? value) {
                      setState(() {
                        foodName = value!;

                      });
                    },
                    onChanged: (value) {
                      
                      setState(() {
                        foodName = value;
                      });
                    },
                    validator: (value) {
                      if (value == null || value.isEmpty || value.length < 3) {
                        return 'Food Name must contain at least 3 characters';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  
                  // Ingredients
                  TextFormField(
                    decoration: const InputDecoration(
                        labelText: 'Ingredients',
                        hintText: 'What are the ingredients of your food?',
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(20.0)),
                          borderSide:
                              BorderSide(color: Colors.grey, width: 0.0),
                        ),
                        border: OutlineInputBorder()),
                    keyboardType: TextInputType.multiline,
                    minLines: 3,
                    maxLines: null,
                    onSaved: (String? value) {
                      setState(() {
                        ingredients = value!;
                      });
                    },
                    onChanged: (value) {
                      setState(() {
                        ingredients = value;
                      });
                    },
                    validator: (value) {
                      if (value == null || value.isEmpty || value.length < 3) {
                        return 'Food Name must contain at least 3 characters';
                      } 
                      return null;
                    },
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                
                  // Method
                  TextFormField(
                    decoration: const InputDecoration(
                        labelText: 'Methods',
                        hintText: 'Tell us the step by step guide of making your food!',
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(20.0)),
                          borderSide:
                              BorderSide(color: Colors.grey, width: 0.0),
                        ),
                        border: OutlineInputBorder()),
                    keyboardType: TextInputType.multiline,
                    minLines: 3,
                    maxLines: null,

                    onSaved: (String? value) {
                      setState(() {
                        method = value!;
                      });
                    },
                    onChanged: (value) {
                      setState(() {
                        method = value;
                      });
                    },
                    validator: (value) {
                      if (value == null || value.isEmpty || value.length < 3) {
                        return 'Step by step guide must contain at least 3 characters';
                      } 
                      return null;
                    },
                  ),
                  const SizedBox(
                    height: 20,
                  ),


                  // Add button
                  TextButton(
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(Colors.green),
                    ),
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        add(request, foodName,ingredients, method);
                        Navigator.of(context).pushReplacementNamed("/recipe_page",
                            arguments: args);
                      }
                    },
                    child: const Text(
                      "Add recipe",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ],
              ),
            ),

          ],
        ),
      ),
    );
  }
}
