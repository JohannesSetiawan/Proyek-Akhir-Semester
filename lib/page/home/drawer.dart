// ignore_for_file: prefer_typing_uninitialized_variables, use_build_context_synchronously

import 'package:nutrious/main.dart';
import 'package:nutrious/page/home/profile.dart';
import 'package:provider/provider.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:flutter/material.dart';
import 'package:nutrious/model/user_data.dart';

class DrawerMenu extends StatelessWidget {
  final isAdmin;
  final username;
  final description;
  final nickname;
  final profileURL;
  final isVerified;
  const DrawerMenu({Key? key,
    required this.isAdmin,
    required this.username,
    required this.description,
    required this.nickname,
    required this.profileURL,
    required this.isVerified}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final request = context.watch<CookieRequest>();
    return Drawer(
      child: Column(
        children: [
          UserAccountsDrawerHeader(
            currentAccountPicture: CircleAvatar(
              radius: 50,
              backgroundImage: NetworkImage(
                "$profileURL",
              ),
            ),
            accountEmail: isVerified ? const Text("Verified") : const Text("Not Verified"),
            accountName: Text(nickname, style: const TextStyle(
                fontWeight: FontWeight.w700, fontSize: 15)),
          ),
          ListTile(
            title: const Text("Fundraising"),
            onTap: () {
              Navigator.of(context).pushReplacementNamed(
                  "/donation_list",
                  arguments: UserArguments(
                      isAdmin,
                      username,
                      nickname,
                      description,
                      profileURL,
                      isVerified
                  )
              );
            },
          ),
          const ListTile(
            title: Text("Food-Sharing"),
          ),
          ListTile(
            title: const Text("Calorie Tracker"),
            onTap: () {
              Navigator.of(context).pushReplacementNamed(
                  "/calorietracker_page",
                  arguments: UserArguments(
                      isAdmin,
                      username,
                      nickname,
                      description,
                      profileURL,
                      isVerified
                  )
              );
            },
          ),
          ListTile(
            title: const Text("Food Recipes"),
            onTap: () {
              Navigator.of(context).pushReplacementNamed(
                  "/recipe_page",
                  arguments: UserArguments(
                      isAdmin,
                      username,
                      nickname,
                      description,
                      profileURL,
                      isVerified
                  )
              );
            },
          ),
          const ListTile(
            title: Text("Blog"),
          ),
          ListTile(
            trailing: const Icon(Icons.home, color: Colors.indigo,),
            title: const Text("Back to Home", style: TextStyle(
                fontWeight: FontWeight.w700,
                color: Colors.indigo
            ),),
            onTap: () {
              Navigator.of(context).pushReplacementNamed(
                  "/user_dashboard",
                  arguments: UserArguments(
                      isAdmin,
                      username,
                      nickname,
                      description,
                      profileURL,
                      isVerified
                  )
              );
            },
          ),
          ListTile(
            trailing: const Icon(Icons.person, color: Colors.indigo,),
            title: const Text("View Profile", style: TextStyle(
              fontWeight: FontWeight.w700,
              color: Colors.indigo
            ),),
            onTap: () {
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => MyProfile(isAdmin: isAdmin, username: username, description: description, nickname: nickname, profileURL: profileURL, isVerified: isVerified))
              );
            },
          ),
          ListTile(
            trailing: const Icon(Icons.exit_to_app, color: Colors.redAccent,),
            title: const Text("Log Out", style: TextStyle(
                fontWeight: FontWeight.w700,
                color: Colors.redAccent
            ),),
            onTap: () async {
              final response = await request.logout("https://nutrious.up.railway.app/auth/logout/");
              if (response != null){
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => const MyApp())
                );
              }
            },
          ),
        ],
      ),
    );
  }
}
