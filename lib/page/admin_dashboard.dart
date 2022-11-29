import 'package:flutter/material.dart';
import 'package:nutrious/page/profile.dart';

class AdminDashboard extends StatelessWidget {
  final isAdmin;
  final username;
  final nickname;
  final desc;
  final profURL;
  final isVerified;
  const AdminDashboard({Key? key,
    required this.isAdmin,
    required this.username,
    required this.nickname,
    required this.desc,
    required this.profURL,
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
      drawer: Drawer(
        child: Column(
          children: [
            UserAccountsDrawerHeader(
              currentAccountPicture: CircleAvatar(
                radius: 50,
                backgroundImage: NetworkImage(
                  profURL,
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
                    MaterialPageRoute(builder: (context) => AdminDashboard(isAdmin: isAdmin, username: username, nickname: nickname, desc: desc, profURL: profURL, isVerified: isVerified)
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
                    MaterialPageRoute(builder: (context) => MyProfile(isAdmin: isAdmin, username: username, description: desc, nickname: nickname, profileURL: profURL, isVerified: isVerified))
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
      ),
      body: Center(
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.all(5.0),
              margin: EdgeInsets.all(10),
              child: Text("Admin Dashboard", style: TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: 20
              ),),
            )
          ],
        ),
      ),
    );
  }
}
