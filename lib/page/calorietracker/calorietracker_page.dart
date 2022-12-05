import 'package:flutter/material.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:provider/provider.dart';
import 'package:nutrious/util/curr_converter.dart';
import '../../model/user_data.dart';
import '../home/drawer.dart';
import 'addcalorie_page.dart';
import 'reducecalorie_page.dart';
import 'edit_add.dart';
import 'edit_reduce.dart';
import 'package:nutrious/model/calorie.dart';
class CalorieTrackerPage extends StatefulWidget {
  
  const CalorieTrackerPage({Key? key}) : super(key: key);

  @override
  State<CalorieTrackerPage> createState() => _CalorieTrackerPageState();
}

class _CalorieTrackerPageState extends State<CalorieTrackerPage> {
  void delete(request, id) async {
    String pk = id.toString();
    var response = await request.post('https://nutrious.up.railway.app/calorietracker/deletef/',
        {"id" : pk});
  }
  @override
  Widget build(BuildContext context) {
    final request = context.watch<CookieRequest>();
    final args = ModalRoute.of(context)!.settings.arguments as UserArguments;
    Future<List<Calorie>> fetchCalorie() async {
      final response = await request.get("https://nutrious.up.railway.app/calorietracker/show_jsonf/");
      print(response);
      List<Calorie> listCalorie = [];
      for (var i in response["data"]){
        if (i != null){
          print(Calorie.fromJson(i));
          listCalorie.add(Calorie.fromJson(i));
          print("tets");
        }
      }
      
      return listCalorie;
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
                child: Column(
                  children: [
                    Text("Welcome to Calorie Tracker, ${args.nickname} !\n", 
                    style: TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 30
                      ),
                    ),
                    Text("This is your calorie tracker for today\n",
                    style: TextStyle(
                      fontSize: 15
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        TextButton(
                          child: const Text(
                            "Add Calorie",
                            style: TextStyle(color: Colors.white),
                          ),
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all(Colors.blue),
                          ),
                          onPressed: () {
                            Navigator.push(context,
                                MaterialPageRoute(builder: (context) =>
                                    AddCaloriePage(args: args)));
                          },
                        ),
                        TextButton(
                          child: const Text(
                            "Reduce Calorie",
                            style: TextStyle(color: Colors.white),
                          ),
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all(Colors.blue),
                          ),
                          onPressed: () {
                            Navigator.push(context,
                                MaterialPageRoute(builder: (context) =>
                                    ReduceCaloriePage(args: args)));
                          },
                        ),
                          ],
                    ),
                        Expanded(
                          flex: 10,
                          child: FutureBuilder(
                            future: fetchCalorie(),
                            builder: (context, AsyncSnapshot snapshot){
                              if (snapshot.data == null){
                                return const Center(child: CircularProgressIndicator());
                              } else{
                                if (!snapshot.hasData) {
                                  return const Text("You haven't input calories you consumed or burned today");
                                } else{
                                  return ListView.builder(
                                    padding: const EdgeInsets.all(7),
                                    itemCount: snapshot.data!.length,
                                    itemBuilder: (_, index) => Container(
                                        padding: const EdgeInsets.all(10),
                                        margin: const EdgeInsets.all(5),
                                        height: 175,
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

                                          child: Column(
                                            children: [
                                              // Name
                                              Expanded(
                                                flex: 1,
                                                child: Align(
                                                  alignment: Alignment.topLeft,
                                                  child: Text("${snapshot.data![index].category}",
                                                    textAlign: TextAlign.left,
                                                    overflow: TextOverflow.ellipsis,
                                                    style: const TextStyle(
                                                        fontWeight: FontWeight.w700,
                                                        fontSize: 30
                                                    ),),
                                                ),
                                              ),
                                              //Calorie
                                              Expanded(
                                                flex: 1,
                                                child: Align(
                                                  alignment: Alignment.topLeft,
                                                  child: Text("Calorie: ${snapshot.data![index].calorie.toString()}",
                                                    textAlign: TextAlign.left,
                                                    overflow: TextOverflow.ellipsis,
                                                    style: const TextStyle(
                                                        fontSize: 15
                                                    ),),
                                                ),
                                              ),

                                              // Description
                                              Expanded(
                                                flex: 1,
                                                child: Align(
                                                  alignment: Alignment.topLeft,
                                                  child: Text("Description: ${snapshot.data![index].description} " ,
                                                    textAlign: TextAlign.left,
                                                    overflow: TextOverflow.ellipsis,
                                                    style: const TextStyle(
                                                        fontSize: 15
                                                    ),),
                                                ),
                                              ),
                                              // Button for delete
                                              Expanded(
                                                flex: 1,
                                                child: Align(
                                                  alignment: Alignment.topLeft,
                                                  child: TextButton(
                                                    child: const Text(
                                                      "Delete",
                                                      style: TextStyle(color: Colors.white),
                                                    ),
                                                    style: ButtonStyle(
                                                      backgroundColor: MaterialStateProperty.all(Colors.blue),
                                                    ),
                                                    onPressed: () {
                                                      delete(request, snapshot.data![index].pk);
                                                      Navigator.of(context).pushReplacementNamed(
                                                          "/calorietracker_page",
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
                                                ),
                                              ),
                                               // Button for edit_add
                                              if(snapshot.data![index].isIncreasing)
                                              Expanded(
                                                flex: 1,
                                                child: Align(
                                                  alignment: Alignment.topLeft,
                                                  child: TextButton(
                                                    child: const Text(
                                                      "Edit",
                                                      style: TextStyle(color: Colors.white),
                                                    ),
                                                    style: ButtonStyle(
                                                      backgroundColor: MaterialStateProperty.all(Colors.blue),
                                                    ),
                                                    onPressed: () {
                                                      Navigator.push(
                                                        context,
                                                        MaterialPageRoute(builder: (context) =>EditAddCaloriePage(mycalorie: snapshot.data![index], args: args)
                                                        ),
                                                      );
                                                    }
                                                  ),
                                                ),
                                              ),
                                              if(snapshot.data![index].isIncreasing== false)
                                              Expanded(
                                                flex: 1,
                                                child: Align(
                                                  alignment: Alignment.topLeft,
                                                  child: TextButton(
                                                    child: const Text(
                                                      "Edit",
                                                      style: TextStyle(color: Colors.white),
                                                    ),
                                                    style: ButtonStyle(
                                                      backgroundColor: MaterialStateProperty.all(Colors.blue),
                                                    ),
                                                    onPressed: () {
                                                      Navigator.push(
                                                        context,
                                                        MaterialPageRoute(builder: (context) =>EditReduceCaloriePage(mycalorie: snapshot.data![index], args: args)
                                                        ),
                                                      );
                                                    }
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        )
                                  );
                                }
                              }
                            },
                          ),
                        )
                    
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
     
    );
  }
}
