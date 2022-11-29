import 'package:flutter/material.dart';
import 'package:nutrious/page/drawer.dart';

class UserDashboard extends StatelessWidget {
  final nickname;
  final desc;
  final profURL;
  final isVerified;
  const UserDashboard({Key? key, required this.nickname, required this.desc, required this.profURL, required this.isVerified}) : super(key: key);

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
      drawer: DrawerMenu(nickname: nickname, profileURL: profURL, isVerified: isVerified,),
      body: Center(
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(5),
              margin: const EdgeInsets.fromLTRB(10, 10, 10, 0),
              child: RichText(
                text: TextSpan(
                  children: [
                    const TextSpan(
                      text: "Hello, ",
                      style: TextStyle(
                        color: Colors.black,
                        fontFamily: 'Poppins',
                        fontSize: 20,
                      )
                    ),
                    TextSpan(
                      text: nickname,
                      style: const TextStyle(
                        fontWeight: FontWeight.w700,
                        color: Colors.black,
                        fontFamily: 'Poppins',
                        fontSize: 20,
                      )
                    ),
                    const TextSpan(
                      text: "!",
                      style: TextStyle(
                        color: Colors.black,
                        fontFamily: 'Poppins',
                        fontSize: 20,
                      )
                    )
                  ]
                ),
              )
            ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                children: [
                  Stack(
                    alignment: Alignment.center,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(30),
                        child: Image.asset('images/bg-header.png'),
                      ),
                      Container(
                        padding: const EdgeInsets.all(8),
                        child: Column(
                          children: const [
                            Center(child: Text("Welcome to Nutrious!", textAlign: TextAlign.center, style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w700,
                              color: Colors.white
                            ),)),
                            SizedBox(height: 3,),
                            Center(child: Text("With great nutrition, comes great health. So, help yourself and others to achieve good health!", textAlign: TextAlign.center, style: TextStyle(
                              fontSize: 15,
                              color: Colors.white
                            ),))
                          ],
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
