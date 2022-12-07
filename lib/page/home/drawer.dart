// ignore_for_file: prefer_typing_uninitialized_variables, use_build_context_synchronously

import 'package:nutrious/main.dart';
import 'package:nutrious/page/home/profile.dart';
import 'package:provider/provider.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:flutter/material.dart';
import 'package:nutrious/model/user_data.dart';

class DrawerMenu extends StatefulWidget {
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
  State<DrawerMenu> createState() => _DrawerMenuState();
}

class _DrawerMenuState extends State<DrawerMenu> {
  bool isLoading = false;
  bool isTimedOut = false;
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
                "${widget.profileURL}",
              ),
            ),
            accountEmail: widget.isVerified ? const Text("Verified") : const Text("Not Verified"),
            accountName: Text(widget.nickname, style: const TextStyle(
                fontWeight: FontWeight.w700, fontSize: 15)),
          ),
          ListTile(
            title: const Text("Fundraising"),
            onTap: () {
              Navigator.of(context).pushReplacementNamed(
                  "/donation_list",
                  arguments: UserArguments(
                      widget.isAdmin,
                      widget.username,
                      widget.nickname,
                      widget.description,
                      widget.profileURL,
                      widget.isVerified
                  )
              );
            },
          ),
          ListTile(
            title: const Text("Food-Sharing"),
            onTap: () {
                Navigator.of(context).pushReplacementNamed(
                  "/foodsharing_page",
                  arguments: UserArguments(
                      widget.isAdmin,
                      widget.username,
                      widget.nickname,
                      widget.description,
                      widget.profileURL,
                      widget.isVerified
                  )
              );
            },
          ),
          ListTile(
            title: const Text("Calorie Tracker"),
            onTap: () {
              Navigator.of(context).pushReplacementNamed(
                  "/calorietracker_page",
                  arguments: UserArguments(
                      widget.isAdmin,
                      widget.username,
                      widget.nickname,
                      widget.description,
                      widget.profileURL,
                      widget.isVerified
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
                      widget.isAdmin,
                      widget.username,
                      widget.nickname,
                      widget.description,
                      widget.profileURL,
                      widget.isVerified
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
                      widget.isAdmin,
                      widget.username,
                      widget.nickname,
                      widget.description,
                      widget.profileURL,
                      widget.isVerified
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
                  MaterialPageRoute(builder: (context) => MyProfile(isAdmin: widget.isAdmin, username: widget.username, description: widget.description, nickname: widget.nickname, profileURL: widget.profileURL, isVerified: widget.isVerified))
              );
            },
          ),
          isLoading? const CircularProgressIndicator() :
            ListTile(
              trailing: const Icon(Icons.exit_to_app, color: Colors.redAccent,),
              title: const Text("Log Out", style: TextStyle(
                  fontWeight: FontWeight.w700,
                  color: Colors.redAccent
              ),),
              onTap: () async {
                setState(() {
                  isLoading = true;
                });
                final response = await request.logout("https://nutrious.up.railway.app/auth/logout/").timeout(
                    const Duration(seconds: 10),
                    onTimeout: () {
                      setState((){
                        isLoading = false;
                        isTimedOut = true;
                      });
                    }
                );
                setState(() {
                  isLoading = false;
                });
                if (response != null){
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => const MyApp())
                  );
                } else {
                  showDialog(context: context, builder: (context) {
                    return AlertDialog(
                      shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(15.0))
                      ),
                      title: const Text("Log Out Failed", style: TextStyle(
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
                            child: const Text("Back", style: TextStyle(
                              fontWeight: FontWeight.w700,
                            ),),
                          ),
                        ),
                      ],
                    );
                  });
                }
              },
          ),
        ],
      ),
    );
  }
}
