import 'package:flutter/material.dart';

class UserDetail extends StatelessWidget {
  final id;
  final detail;
  const UserDetail({Key? key, required this.id, required this.detail}) : super(key: key);

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
      body: Center(
        child: ListView(
          children: [
            Container(
              margin: const EdgeInsets.all(15),
              child: const Text("Detail", textAlign: TextAlign.center, style: TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: 25,
              ),),
            ),
            Center(
              child: CircleAvatar(
                backgroundImage: NetworkImage(detail.profilePictUrl),
                radius: 80,
              ),
            ),
            Container(
              margin: const EdgeInsets.all(10),
              padding: const EdgeInsets.all(5),
              child: Column(
                children: [
                  const Text("Username", style: TextStyle(
                    fontSize: 16
                  ),),
                  Text(detail.username,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 18
                  ),)
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.all(10),
              padding: const EdgeInsets.all(5),
              child: Column(
                children: [
                  const Text("Nickname", style: TextStyle(
                      fontSize: 16
                  ),),
                  Text(detail.nickname,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 18
                    ),)
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.all(10),
              padding: const EdgeInsets.all(5),
              child: Column(
                children: [
                  const Text("User ID", style: TextStyle(
                      fontSize: 16
                  ),),
                  Text(id,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 18
                    ),)
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.all(10),
              padding: const EdgeInsets.all(5),
              child: Column(
                children: [
                  const Text("Description", style: TextStyle(
                      fontSize: 16
                  ),),
                  Text(detail.description == "" ? "-" : detail.description,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 18
                    ),)
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.all(10),
              padding: const EdgeInsets.all(5),
              child: Column(
                children: [
                  const Text("Status", style: TextStyle(
                      fontSize: 16
                  ),),
                  detail.isVerifiedUser ?
                  const Text("Verified",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 18,
                        color: Colors.green
                    ),) : const Text("Not Verified",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 18,
                        color: Colors.red
                    ),)
                ],
              ),
            ),
          ],
        ),
      )
    );
  }
}
