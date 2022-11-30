import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:nutrious/page/login.dart';
import 'package:nutrious/page/drawer.dart';
import 'package:nutrious/page/user_dashboard.dart';
import 'package:nutrious/page/admin_dashboard.dart';
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
        home: const MyHomePage(title: 'Nutrious'),
        routes: {
          "/login": (BuildContext context) => const LoginPage(),
          "/user_dashboard": (BuildContext context) => const UserDashboard(),
        },
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
  @override
  Widget build(BuildContext context){
    return Scaffold(
      backgroundColor: const Color(0xFFF0FFFF),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('images/NUTRIOUS.png', width: 300),
            Container(
              margin: const EdgeInsets.all(5),
              child: const Text("Welcome to Nutrious!", style: TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: 20,
              ),),
            ),
            TextButton(
              // TODO: add route, use pushReplacementNamed
              child: const Text("Log In"),
              onPressed: (){
                Navigator.of(context).pushReplacementNamed("/login");
              },
            ),
            TextButton(
              child: const Text("Register"),
              onPressed: (){
              },
            )
          ],
        ),
      ),
    );
  }
}
