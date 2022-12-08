import 'package:flutter/material.dart';
import 'package:nutrious/page/donation/donation_list.dart';
import 'package:nutrious/page/calorietracker/calorietracker_page.dart';
import 'package:nutrious/page/recipe/recipe_page.dart';
import 'package:nutrious/page/home/list_fundraising.dart';
import 'package:nutrious/page/home/login.dart';
import 'package:nutrious/page/home/user_dashboard.dart';
import 'package:nutrious/page/home/admin_dashboard.dart';
import 'package:nutrious/page/blog/blog_list.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:provider/provider.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:nutrious/page/home/list_user.dart';
import 'package:nutrious/page/home/list_message.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Provider(
      create: (_) {
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
                  borderSide: BorderSide(color: Colors.indigo),
                  borderRadius: BorderRadius.all(Radius.circular(10.0)))),
        ),
        home: const MyHomePage(title: 'Nutrious'),
        routes: {
          "/login": (BuildContext context) => const LoginPage(),
          "/user_dashboard": (BuildContext context) => const UserDashboard(),
          "/admin_dashboard": (BuildContext context) => const AdminDashboard(),
          "/user_list": (BuildContext context) => const UserList(),
          "/fundraising_list": (BuildContext context) =>
              const FundraisingList(),
          "/message_list": (BuildContext context) => const MessageList(),
          "/donation_list": (BuildContext context) => const DonationList(),
          "/calorietracker_page": (BuildContext context) =>
              const CalorieTrackerPage(),
          "/recipe_page": (BuildContext context) => const RecipePage(),
          "/blog_list": (BuildContext context) => const BlogList(),
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
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF0FFFF),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('images/NUTRIOUS.png', width: 300),
            Container(
              margin: const EdgeInsets.all(5),
              child: const Text(
                "Welcome to Nutrious!",
                style: TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 20,
                ),
              ),
            ),
            TextButton(
              style: ButtonStyle(
                  shape: MaterialStateProperty.all(RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                      side: const BorderSide(color: Colors.indigo)))),
              onPressed: () {
                Navigator.of(context).pushReplacementNamed("/login");
              },
              child: const Text("Log In"),
            ),
            const SizedBox(
              height: 2,
            ),
            TextButton(
              style: ButtonStyle(
                  shape: MaterialStateProperty.all(RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                      side: const BorderSide(color: Colors.indigo)))),
              child: const Text("Register"),
              onPressed: () {
                launchUrl(
                    Uri.parse("https://nutrious.up.railway.app/register/"));
              },
            )
          ],
        ),
      ),
    );
  }
}
