import 'package:nutrious/main.dart';
import 'package:nutrious/page/profile.dart';
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
          const ListTile(
            title: Text("Fundraising"),
          ),
          const ListTile(
            title: Text("Food-Sharing"),
          ),
          const ListTile(
            title: Text("Calorie Tracker"),
          ),
          const ListTile(
            title: Text("Food Recipes"),
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
            trailing: Icon(Icons.exit_to_app, color: Colors.redAccent,),
            title: const Text("Log Out", style: TextStyle(
                fontWeight: FontWeight.w700,
                color: Colors.redAccent
            ),),
            onTap: () async {
              final response = await request.logout("https://nutrious.up.railway.app/auth/logout/");
              if (response != null){
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => MyApp())
                );
              }
            },
          ),
        ],
      ),
    );
  }
}
