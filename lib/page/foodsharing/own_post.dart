import 'package:flutter/material.dart';
import 'package:getwidget/getwidget.dart';
import 'package:nutrious/page/foodsharing/edit_foodsharing.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:provider/provider.dart';

import '../../model/foodsharing.dart';
import '../../model/user_data.dart';
import '../home/drawer.dart';

class OwnPost extends StatefulWidget {
  final dynamic args;
  const OwnPost({Key? key, required this.args}) : super(key: key);

  @override
  State<OwnPost> createState() => _OwnPostState();
}

class _OwnPostState extends State<OwnPost> {

  delete(request, id) async {
    String pk = id.toString();
    var response = await request.post('https://nutrious.up.railway.app/foodsharing/deletef',
        {"id" : pk});
    return response;
  }

  @override
  Widget build(BuildContext context) {
    final request = context.watch<CookieRequest>();
    final args = widget.args;
    Future<List<Foodsharing>> fetchFoodsharing() async {
      final response = await request.get("https://nutrious.up.railway.app/foodsharing/show_json_by_user");
      List<Foodsharing> listFoodsharing = [];
      for (var foodsharing in response["data"]){
        if (foodsharing != null){
          listFoodsharing.add(Foodsharing.fromJson(foodsharing));
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
              borderRadius: BorderRadius.vertical(
                  bottom: Radius.circular(30)
              )
          ),
          iconTheme: const IconThemeData(color: Colors.indigo)
      ),
      drawer: DrawerMenu(
        isAdmin: args.isAdmin,
        username: args.username,
        description: args.desc,
        nickname: args.nickname,
        profileURL: args.profURL,
        isVerified: args.isVerified,),
      body: Center(
        child: Column(
          children: [
            Expanded(
              flex: 1,
              child: Container(
                margin: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                child: const Text("List of Your Own Post", style: TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 20
                ),),
              ),
            ),
            Expanded(
              flex: 10,
              child: FutureBuilder(
                future: fetchFoodsharing(),
                builder: (context, AsyncSnapshot snapshot){
                  if (snapshot.data == null){
                    return const Center(child: CircularProgressIndicator());
                  } else{
                    if (!snapshot.hasData) {
                      return const Text("No Post Food-Sharing");
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
                              title: Text('Post by: ${snapshot.data![index].author}',),
                              
                            ),
                            content: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        RichText(
                                            
                                              text: TextSpan(
                                                text: "Location: ",
                                                style: const TextStyle( fontFamily: "Poppins",color: Colors.black, fontSize: 14,fontWeight: FontWeight.w700,),
                                              children: <TextSpan>[
                                                  TextSpan(
                                                  text: "${snapshot.data![index].location}\n",
                                                  style: const TextStyle( fontFamily: "Poppins", fontSize: 14, fontWeight: FontWeight.w400),
                                                  ),
                                              ],
                                              ),
                                          ),
                                          RichText(
                                        
                                              text: TextSpan(
                                                text: "Description: ",
                                                style: const TextStyle( fontFamily: "Poppins",color: Colors.black, fontSize: 14,fontWeight: FontWeight.w700,),
                                              children: <TextSpan>[
                                                  TextSpan(
                                                  text: "${snapshot.data![index].description}\n",
                                                  style: const TextStyle( fontFamily: "Poppins", fontSize: 14, fontWeight: FontWeight.w400),
                                                  ),
                                              ],
                                              ),
                                          ),
                                          RichText(
                                         
                                              text: TextSpan(
                                                text: "Date: ",
                                                style: const TextStyle( fontFamily: "Poppins",color: Colors.black, fontSize: 14,fontWeight: FontWeight.w700,),
                                              children: <TextSpan>[
                                                  TextSpan(
                                                  text: "${snapshot.data![index].date}\n",
                                                  style: const TextStyle( fontFamily: "Poppins", fontSize: 14, fontWeight: FontWeight.w400),
                                                  ),
                                              ],
                                              ),
                                          ),
                                          RichText(
                                       
                                              text: TextSpan(
                                                text: "Update Date: ",
                                                style: const TextStyle( fontFamily: "Poppins",color: Colors.black, fontSize: 14,fontWeight: FontWeight.w700,),
                                              children: <TextSpan>[
                                                  TextSpan(
                                                  text: "${snapshot.data![index].updateDate}",
                                                  style: const TextStyle( fontFamily: "Poppins", fontSize: 14, fontWeight: FontWeight.w400),
                                                  ),
                                              ],
                                              ),
                                          ),
                                      ],
                                    ),
                            buttonBar: GFButtonBar(
                              children: <Widget>[
                                // GFButton(
                                //   onPressed: () { 
                                //     delete(request, snapshot.data![index].pk);
                                //           Navigator.push(context,
                                //               MaterialPageRoute(builder: (context) =>
                                //                   OwnPost(args: args)));},
                                //   text: 'Delete',
                                // ),
                                IconButton(onPressed: () {
                                      delete(request, snapshot.data![index].pk);
                                      Navigator.push(
                                      context,
                                      MaterialPageRoute(builder: (context) =>OwnPost(args: args)
                                      ),
                                    );
                                  }, icon: const Icon(Icons.delete_forever)),
                                  IconButton(onPressed: () {
                                      Navigator.push(
                                      context,
                                      MaterialPageRoute(builder: (context) =>EditFoodsharingPage(mypost: snapshot.data![index], args: args)
                                      ),
                                    );
                                  }, icon: const Icon(Icons.edit)),
                              ],
                          ),
                          

                            ),
                         
                      );
                    }
                  }
                },
              ),
            ),
             Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                TextButton(
                  // ignore: sort_child_properties_last
                  child: const Text(
                    "Back",
                    style: TextStyle(color: Colors.white),
                  ),
                  style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all(Colors.blue),
                  ),
                  onPressed: () {
              
                      Navigator.of(context).pushReplacementNamed(
                        "/foodsharing_page",
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
                
              ],
            ),

          ],
        ),
      ),
    );
  }
}
