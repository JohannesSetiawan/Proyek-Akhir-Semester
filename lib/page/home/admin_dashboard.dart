// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:nutrious/page/home/profile.dart';
import 'package:nutrious/model/user_data.dart';
import 'package:provider/provider.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:nutrious/main.dart';

class AdminDashboard extends StatelessWidget {
  const AdminDashboard({Key? key,}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final request = context.watch<CookieRequest>();
    final args = ModalRoute.of(context)!.settings.arguments as UserArguments;

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
                  args.profURL,
                ),
              ),
              accountEmail: const Text('Admin'),
              accountName: Text(args.nickname, style: const TextStyle(
                  fontWeight: FontWeight.w700, fontSize: 15)),
            ),
            ListTile(
              trailing: const Icon(Icons.home, color: Colors.indigo,),
              title: const Text("Back to Home", style: TextStyle(
                  fontWeight: FontWeight.w700,
                  color: Colors.indigo
              ),),
              onTap: () {
                Navigator.of(context).pushReplacementNamed(
                    "/admin_dashboard",
                    arguments: UserArguments(
                        args.isAdmin,
                        args.username,
                        args.nickname,
                        args.desc,
                        args.profURL,
                        args.isVerified
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
                    MaterialPageRoute(builder: (context) => MyProfile(isAdmin: args.isAdmin, username: args.username, description: args.desc, nickname: args.nickname, profileURL: args.profURL, isVerified: args.isVerified))
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
              },)
          ],
        ),
      ),
      body: Center(
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(5.0),
              margin: const EdgeInsets.all(10),
              child: const Text("Admin Dashboard", style: TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: 20
              ),),
            ),
            Expanded(
              child: Container(
                margin: const EdgeInsets.fromLTRB(10, 0, 10, 10),
                padding: const EdgeInsets.all(5),
                child: Column(
                  children: [
                    Expanded(
                      flex: 1,
                      child: Container(
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: const BorderRadius.all(Radius.circular(10)),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.5),
                                spreadRadius: 2,
                                blurRadius: 1,
                              )
                            ]
                        ),
                        padding: const EdgeInsets.all(5),
                        margin: const EdgeInsets.all(10),
                        height: 50,
                        child: InkWell(
                          child: const Center(
                            child: Text("List of User(s)",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontWeight: FontWeight.w700,
                                  fontSize: 20
                              ),),
                          ),
                          onTap: () {
                            Navigator.of(context).pushNamed("/user_list");
                          },
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Container(
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: const BorderRadius.all(Radius.circular(10)),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.5),
                                spreadRadius: 2,
                                blurRadius: 1,
                              )
                            ]
                        ),
                        padding: const EdgeInsets.all(5),
                        margin: const EdgeInsets.all(10),
                        height: 50,
                        child: InkWell(
                          child: const Center(
                            child: Text("List of Fundraising(s)",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontWeight: FontWeight.w700,
                                  fontSize: 20
                              ),),
                          ),
                          onTap: () {
                            Navigator.of(context).pushNamed("/fundraising_list");
                          },
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Container(
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: const BorderRadius.all(Radius.circular(10)),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.5),
                                spreadRadius: 2,
                                blurRadius: 1,
                              )
                            ]
                        ),
                        padding: const EdgeInsets.all(5),
                        margin: const EdgeInsets.all(10),
                        height: 50,
                        child: InkWell(
                          child: const Center(
                            child: Text("List of Message(s)",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontWeight: FontWeight.w700,
                                  fontSize: 20
                              ),),
                          ),
                          onTap: () {
                            Navigator.of(context).pushNamed("/message_list");
                          },
                        ),
                      ),
                    )
                  ],
                ),
              )
            )
          ],
        ),
      ),
    );
  }
}
