import 'package:flutter/material.dart';
import 'package:nutrious/page/admin_dashboard.dart';
import 'package:nutrious/page/drawer.dart';

class MyProfile extends StatelessWidget {
  final isAdmin;
  final username;
  final description;
  final nickname;
  final profileURL;
  final isVerified;
  const MyProfile({Key? key,
    required this.isAdmin,
    required this.username,
    required this.description,
    required this.nickname,
    required this.profileURL,
    required this.isVerified}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
      drawer: isAdmin? Drawer(
        child: Column(
          children: [
            UserAccountsDrawerHeader(
              currentAccountPicture: CircleAvatar(
                radius: 50,
                backgroundImage: NetworkImage(
                  profileURL,
                ),
              ),
              accountEmail: const Text('Admin'),
              accountName: Text(nickname, style: const TextStyle(
                  fontWeight: FontWeight.w700, fontSize: 15)),
            ),
            ListTile(
              trailing: const Icon(Icons.home, color: Colors.indigo,),
              title: const Text("Back to Home", style: TextStyle(
                  fontWeight: FontWeight.w700,
                  color: Colors.indigo
              ),),
              onTap: () {
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => const AdminDashboard()
                ));
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
            const ListTile(
              trailing: Icon(Icons.exit_to_app, color: Colors.redAccent,),
              title: Text("Log Out", style: TextStyle(
                  fontWeight: FontWeight.w700,
                  color: Colors.redAccent
              ),),)
          ],
        ),
      ): DrawerMenu(isAdmin: isAdmin, username: username, description: description, nickname: nickname, profileURL: profileURL, isVerified: isVerified,),
      body: Flex(
        direction: Axis.vertical,
        children: [Expanded(
          child: ListView(
            children: [
              Container(
                padding: const EdgeInsets.all(5.0),
                margin: const EdgeInsets.all(10),
                child: const Text("My Profile", textAlign: TextAlign.center, style: TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 20
                ),),
              ),
              Center(
                child: CircleAvatar(
                  backgroundImage: NetworkImage(profileURL),
                  radius: 80,
                ),
              ),
              const SizedBox(height: 10,),
              Container(
                margin: const EdgeInsets.all(5),
                child: const Text("Username", textAlign: TextAlign.center),
              ),
              Container(
                margin: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                child: Text(username, textAlign: TextAlign.center, style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w700
                ),),
              ),
              const SizedBox(height: 10,),
              Container(
                margin: const EdgeInsets.all(5),
                child: const Text("Nickname", textAlign: TextAlign.center),
              ),
              Container(
                margin: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                child: Text(nickname, textAlign: TextAlign.center, style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w700
                ),),
              ),
              const SizedBox(height: 10,),
              Container(
                margin: const EdgeInsets.all(5),
                child: const Text("Description", textAlign: TextAlign.center),
              ),
              Container(
                margin: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                child: Text(description, textAlign: TextAlign.center, style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w700
                ),),
              ),
              const SizedBox(height: 10,),
              Container(
                margin: const EdgeInsets.all(5),
                child: const Text("Status", textAlign: TextAlign.center),
              ),
              Container(
                margin: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                child: Text(isAdmin? "Admin"
                  : (isVerified? "Verified": "Not Verified"),
                  textAlign: TextAlign.center, style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w700
                ),),
              ),
              const SizedBox(height: 10,),
            ],
          ),
        )],
      ),
    );
  }
}
