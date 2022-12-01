// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:nutrious/model/user_data.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:provider/provider.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:flutter/gestures.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  String username = '';
  String password1 = '';
  bool isPasswordVisible = true;
  bool isLoading = false;

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
                          padding: const EdgeInsets.all(7),
                          child: !isLoading ? Column(
                            children: [
                              OutlinedButton(
                                onPressed: () async {
                                  FocusScopeNode currentFocus = FocusScope.of(context);
                                  if (!currentFocus.hasPrimaryFocus) {
                                    currentFocus.unfocus();
                                  }
                                  if (_formKey.currentState!.validate()) {
                                    setState((){
                                      isLoading=true;
                                    });
                                    final response = await request.login("https://nutrious.up.railway.app/auth/login/", {
                                      'username': username,
                                      'password': password1,
                                    }).timeout(
                                      const Duration(seconds: 10),
                                      onTimeout: () {
                                        setState((){
                                          isLoading=false;
                                        });
                                        return AlertDialog(
                                          shape: const RoundedRectangleBorder(
                                              borderRadius: BorderRadius.all(Radius.circular(15.0))
                                          ),
                                          title: const Text("Login Failed", style: TextStyle(
                                            fontWeight: FontWeight.w700,
                                          ),),
                                          content: const Text("Check your internet connection."),
                                          actions: <Widget>[
                                            TextButton(
                                              onPressed: () {
                                                Navigator.of(context).pop();
                                              },
                                              child: Container(
                                                padding: const EdgeInsets.all(5),
                                                child: const Text("Close", style: TextStyle(
                                                  fontWeight: FontWeight.w700,
                                                ),),
                                              ),
                                            ),
                                          ],
                                        );
                                      }
                                    );
                                    setState((){
                                      isLoading=false;
                                    });
                                    if (request.loggedIn){
                                      if (response["is_admin"]){
                                        Navigator.of(context).pushReplacementNamed(
                                            "/admin_dashboard",
                                            arguments: UserArguments(
                                                response["is_admin"],
                                                response["username"],
                                                response["nickname"],
                                                response["description"],
                                                response["profile_pict_url"],
                                                response["is_verified_user"]
                                            )
                                        );
                                      }
                                      else{
                                        Navigator.of(context).pushReplacementNamed(
                                          "/user_dashboard",
                                          arguments: UserArguments(
                                            response["is_admin"],
                                            response["username"],
                                            response["nickname"],
                                            response["description"],
                                            response["profile_pict_url"],
                                            response["is_verified_user"]
                                          )
                                        );
                                      }
                                    } else{
                                      showDialog(context: context, builder: (context) {
                                        return AlertDialog(
                                          shape: const RoundedRectangleBorder(
                                              borderRadius: BorderRadius.all(Radius.circular(15.0))
                                          ),
                                          title: const Text("Log In Failed", style: TextStyle(
                                            fontWeight: FontWeight.w700,
                                          ),),
                                          content: const Text("Your username or password is wrong."),
                                          actions: <Widget>[
                                            TextButton(
                                              onPressed: () {
                                                Navigator.of(context).pop();
                                              },
                                              child: Container(
                                                padding: const EdgeInsets.all(5),
                                                child: const Text("Back", style: TextStyle(
                                                  fontWeight: FontWeight.w700,
                                                ),),
                                              ),
                                            ),
                                          ],
                                        );
                                      });
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
                                    fontSize: 18
                                ),),
                              ),
                              const SizedBox(height: 2),
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
                          ) : const Center(child: CircularProgressIndicator()),
                        ),
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
