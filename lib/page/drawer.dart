import 'package:nutrious/main.dart';
import 'package:provider/provider.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:flutter/material.dart';

class DrawerMenu extends StatelessWidget {
  final nickname;
  final profileURL;
  final isVerified;
  const DrawerMenu({Key? key, required this.nickname, required this.profileURL, required this.isVerified}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          UserAccountsDrawerHeader(
            currentAccountPicture: CircleAvatar(
              radius: 50,
              backgroundImage: NetworkImage(
                profileURL,
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
          const ListTile(
            title: Text("View Profile", style: TextStyle(
              fontWeight: FontWeight.w700,
            ),),
          ),
          const ListTile(
            title: Text("Log Out", style: TextStyle(
                fontWeight: FontWeight.w700,
                color: Colors.redAccent
            ),),
            //onTap: () async {
            //  Navigator.pushReplacement(
            //      context,
            //      MaterialPageRoute(builder: (context) => const MyApp())
            //  );
           // },
          ),
        ],
      ),
    );
  }
}
