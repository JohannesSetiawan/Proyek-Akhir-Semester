import 'package:flutter/material.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:provider/provider.dart';
import '../../model/foodsharing.dart';
import '../../model/user_data.dart';
import '../home/drawer.dart';
import 'add_foodsharing.dart';
import 'package:getwidget/getwidget.dart';

import 'own_post.dart';
class FoodSharingPage extends StatefulWidget {
  const FoodSharingPage({Key? key}) : super(key: key);

  @override
  State<FoodSharingPage> createState() => _FoodSharingPageState();
}

class _FoodSharingPageState extends State<FoodSharingPage> {

  @override
  Widget build(BuildContext context) {
    final request = context.watch<CookieRequest>();
    final args = ModalRoute.of(context)!.settings.arguments as UserArguments;
    // ignore: unused_element
    Future<List<Foodsharing>> fetchFoodsharing() async {
      print("ini response");
      final response = await request.get("https://nutrious.up.railway.app/foodsharing/show_jsonf");
      // final response = await request.get("http://localhost:8000/foodsharing/show_jsonf");
      print(response);
      List<Foodsharing> listFoodsharing = [];
      for (var i in response["data"]) {
        if (i != null) {
          print(Foodsharing.fromJson(i));
          listFoodsharing.add(Foodsharing.fromJson(i));
          print("tests");
        }
      }
      return listFoodsharing;
    }

    return Scaffold(
      appBar: AppBar(
          backgroundColor: const Color(0xFFF0FFFF),
          centerTitle: true,
          title: Image.asset('images/NUTRIOUS.png', height: 75),
          toolbarHeight: 100,
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(bottom: Radius.circular(30))),
          iconTheme: const IconThemeData(color: Colors.indigo)),
      drawer: DrawerMenu(
        isAdmin: args.isAdmin,
        username: args.username,
        description: args.desc,
        nickname: args.nickname,
        profileURL: args.profURL,
        isVerified: args.isVerified,
      ),

      body: Center(
        child: Column(
          children: [
            Expanded(
                flex: 1,
                child: Container(
                    margin: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                    child: Column(
                      children: [
                        const Text(
                          "Food-Sharing Information",
                          style: TextStyle(
                              fontWeight: FontWeight.w700, fontSize: 30),
                        ),
                        Text(
                          "\nHello, ${args.nickname}!",
                          style: const TextStyle(fontSize: 15),
                        ),
                        
                        // const Spacer(),
                        Expanded(
                          flex: 10,
                          child: FutureBuilder(
                            future: fetchFoodsharing(),
                            builder: (context, AsyncSnapshot snapshot){
                              if (snapshot.data == null){
                                return const Center(child: CircularProgressIndicator());
                              } else{
                                if (!snapshot.hasData) {
                                  return const Text("There's no post about food-sharing");
                                } else{
                                  
                                  return ListView.builder(
                                    padding: const EdgeInsets.all(7),
                                    itemCount: snapshot.data!.length,
                                    itemBuilder: (_, index) => 
                                  GFCard(
                                  boxFit: BoxFit.cover,
                                   titlePosition: GFPosition.start,
                                      image: Image.network(
                                        '${snapshot.data![index].img}',
                                        height: MediaQuery.of(context).size.height * 0.2,
                                        width: MediaQuery.of(context).size.width,
                                        fit: BoxFit.cover,
                                      ),
                                  showImage: true,
                                  title:  GFListTile(
                                    title: Text('Post by: ${snapshot.data![index].author}'),
                                   
                                  ),
                                  content: Text("${snapshot.data![index].location}\n${snapshot.data![index].description}\n${snapshot.data![index].date}"),
                               
                                  ),
                                                                    );
                                }
                              }
                            },
                          ),
                        ),



                        if(args.isVerified)
                      // button add postnya
                        Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [

                          TextButton(
                            // ignore: sort_child_properties_last
                            child: const Text(
                              "Add Page",
                              style: TextStyle(color: Colors.white),
                            ),
                            style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all(Colors.blue),
                            ),
                            onPressed: () {
                              Navigator.push(context,
                                  MaterialPageRoute(builder: (context) =>
                                      AddFoodsharingPage(args: args)));
                            },
                          ),
                          TextButton(
                            // ignore: sort_child_properties_last
                            child: const Text(
                              "See Own Post",
                              style: TextStyle(color: Colors.white),
                            ),
                            style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all(Colors.blue),
                            ),
                            onPressed: () {
                              Navigator.push(context,
                                  MaterialPageRoute(builder: (context) =>
                                      OwnPost(args: args)));
                            },
                          ),
                          ],
                      )



                    ]))),
                  
          ],
        ),
      ), // Center
    );
  }
}
