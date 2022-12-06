import 'package:flutter/material.dart';
import 'package:nutrious/page/home/user_detail.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:provider/provider.dart';
import 'package:nutrious/model/user.dart';

class UserList extends StatefulWidget {
  const UserList({Key? key}) : super(key: key);

  @override
  State<UserList> createState() => _UserListState();
}

class _UserListState extends State<UserList> {
  @override
  Widget build(BuildContext context) {
    final request = context.watch<CookieRequest>();
    Future<List<User>> fetchUser() async {
      final response = await request.get("https://nutrious.up.railway.app/json-user/");
      List<User> listUser = [];
      for (var user in response){
        if (user != null){
          listUser.add(User.fromJson(user));
        }
      }
      return listUser;
    }
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
        child: Column(
          children: [
            Expanded(
              flex: 1,
              child: Container(
                margin: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                child: const Text("List of User(s)", style: TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 20
                ),),
              ),
            ),
            Expanded(
              flex: 10,
              child: FutureBuilder(
                future: fetchUser(),
                builder: (context, AsyncSnapshot snapshot){
                  if (snapshot.data == null){
                    return const Center(child: CircularProgressIndicator());
                  } else{
                    if (!snapshot.hasData) {
                      return const Text("No User");
                    } else{
                      return ListView.builder(
                        padding: const EdgeInsets.all(7),
                        itemCount: snapshot.data!.length,
                        itemBuilder: (_, index) => Container(
                          padding: const EdgeInsets.all(10),
                          margin: const EdgeInsets.all(5),
                          height: 80,
                          decoration: BoxDecoration(
                              color:Colors.white,
                              borderRadius: BorderRadius.circular(10),
                              boxShadow: const [
                                BoxShadow(
                                    color: Colors.black,
                                    blurRadius: 2.0
                                )
                              ]
                          ),
                          child: InkWell(
                            onTap: (){
                              Navigator.push(context, MaterialPageRoute(builder: (context) =>
                                UserDetail(id: snapshot.data![index].pk.toString(), detail: snapshot.data![index].fields)));
                            },
                            child: Column(
                              children: [
                                Expanded(
                                  flex: 1,
                                  child: Align(
                                    alignment: Alignment.topLeft,
                                    child: Text(snapshot.data![index].fields.username,
                                      textAlign: TextAlign.left, overflow: TextOverflow.ellipsis,
                                      style: const TextStyle(
                                        fontWeight: FontWeight.w700,
                                        fontSize: 21
                                    ),),
                                  ),
                                ),
                                Expanded(
                                  flex: 1,
                                  child: Row(
                                    children: [
                                      Expanded(
                                        flex: 5,
                                        child: Text(snapshot.data![index].fields.nickname,
                                          overflow: TextOverflow.ellipsis),
                                      ),
                                      Expanded(
                                        flex: 2,
                                        child: Text("ID: ${snapshot.data![index].pk.toString()}",
                                            overflow: TextOverflow.ellipsis),
                                      ),
                                      Expanded(
                                        flex: 3,
                                        child: snapshot.data![index].fields.isVerifiedUser ?
                                          const Text("Verified",
                                            textAlign: TextAlign.right, style: TextStyle(
                                              fontWeight: FontWeight.w700,
                                              color: Colors.green
                                            ),) :
                                          const Text("Not Verified",
                                            textAlign: TextAlign.right, style: TextStyle(
                                              fontWeight: FontWeight.w700,
                                              color: Colors.red
                                            ),),
                                      )
                                    ],
                                  ),
                                )
                              ],
                            ),
                          )
                        ),
                      );
                    }
                  }
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
