import 'dart:convert';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:provider/provider.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Provider(
      create: (_){
        CookieRequest request = CookieRequest();
        return request;
      },
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.indigo,
          //primaryColor: const Color(0xFF004AAD),
          fontFamily: 'Poppins',
          inputDecorationTheme: const InputDecorationTheme(
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: Colors.indigo
              ),
              borderRadius: BorderRadius.all(Radius.circular(10.0))
            )
          ),
        ),
        home: const MyHomePage(title: 'Flutter Demo Home Page'),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final _formKey = GlobalKey<FormState>();
  String username = '';
  String password1 = '';
  bool isPasswordVisible = true;

  void togglePasswordVisibility(){
    setState(() {
      isPasswordVisible = !isPasswordVisible;
    });
  }

  @override
  Widget build(BuildContext context) {
    final request = context.watch<CookieRequest>();
    return Scaffold(
      // Preventing overflow
      // resizeToAvoidBottomInset: false,
      body: Container(
        color: const Color(0xFFF0FFFF) ,
        child: Center(
          child: Container(
            padding: const EdgeInsets.all(15),
            margin: const EdgeInsets.all(30),
            decoration: BoxDecoration(
                borderRadius: const BorderRadius.all(Radius.circular(10)),
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black38.withOpacity(0.2),
                    spreadRadius: 2,
                    blurRadius: 2,
                    offset: const Offset(0, 3),
                  )]
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Image.asset('images/NUTRIOUS.png', width: 250),
                const SizedBox(height: 13),
                Form(
                  key: _formKey,
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(7),
                          child: TextFormField(
                            decoration: InputDecoration(
                              hintText: "Enter Your Username",
                              labelText: "Username",
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                            ),
                            onChanged: (String? value){
                              setState(() {
                                username = value!;
                              });
                            },
                            onSaved: (String? value){
                              setState(() {
                                username = value!;
                              });
                            },
                            validator: (String? value){
                              if (value == null || value.isEmpty){
                                return 'Please fill the username field';
                              }
                              return null;
                            },
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.all(7),
                          child: TextFormField(
                            obscureText: isPasswordVisible,
                            decoration: InputDecoration(
                              hintText: "Enter Your Password",
                              labelText: "Password",
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              suffixIcon: GestureDetector(
                                onTap: (){
                                  togglePasswordVisibility();
                                },
                                child: Icon(
                                  isPasswordVisible ? Icons.visibility_off : Icons.visibility,
                                  size: 20.0,
                                ),
                              )
                            ),
                            onChanged: (String? value){
                              setState(() {
                                password1 = value!;
                              });
                            },
                            onSaved: (String? value){
                              setState(() {
                                password1 = value!;
                              });
                            },
                            validator: (String? value){
                              if (value == null || value.isEmpty){
                                return 'Please fill the password field';
                              }
                              return null;
                            },
                          ),
                        ),
                        Container(
                          width: double.infinity,
                          padding: const EdgeInsets.all(7),
                          child: OutlinedButton(
                            onPressed: () async {
                              if (_formKey.currentState!.validate()) {
                                final response = await request.login("https://nutrious.up.railway.app/auth/login/", {
                                  'username': username,
                                  'password': password1,
                                });
                                if (request.loggedIn){
                                  // do something
                                } else{
                                  // do something
                                }
                              }
                            },
                            style: OutlinedButton.styleFrom(
                              side: const BorderSide(
                                color: Colors.indigo
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0)
                              )
                            ),
                            child: const Text("Log In", style: TextStyle(
                              fontWeight: FontWeight.w700,
                              fontSize: 17
                            ),),
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.all(5),
                          child: RichText(
                            text: TextSpan(
                              children: [
                                const TextSpan(
                                  text: "No Account? ",
                                  style: TextStyle(
                                      fontFamily: "Poppins",
                                      color: Colors.grey)
                                ),
                                TextSpan(
                                  text: "Create a New One",
                                  style: const TextStyle(
                                      fontFamily: "Poppins",
                                      color: Colors.indigo,
                                      fontWeight: FontWeight.w700),
                                  recognizer: TapGestureRecognizer()
                                    ..onTap = (){
                                      launchUrl(Uri.parse("https://nutrious.up.railway.app/register/"));
                                    },
                                )
                              ]
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
