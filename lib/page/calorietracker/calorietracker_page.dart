import 'package:flutter/material.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:provider/provider.dart';
import '../../model/user_data.dart';
import '../home/drawer.dart';
import 'addcalorie_page.dart';
import 'reducecalorie_page.dart';
import 'edit_add.dart';
import 'edit_reduce.dart';
import 'package:nutrious/model/calorie.dart';
import 'package:intl/intl.dart';
class CalorieTrackerPage extends StatefulWidget {
  
  const CalorieTrackerPage({Key? key}) : super(key: key);

  @override
  State<CalorieTrackerPage> createState() => _CalorieTrackerPageState();
}

class _CalorieTrackerPageState extends State<CalorieTrackerPage> {
  int counterAdd = 0;
  int counterDecrease = 0;
  int total =0;
 hitungAdd(int x){
    counterAdd += x;
    return counterAdd.toString();
  }
 hitungDecrease(int x){
    counterDecrease += x;
    return counterDecrease.toString();
  }
 hitungTotal(){
    total = counterAdd-counterDecrease;
    return total.toString();
  }
  void delete(request, id) async {
    String pk = id.toString();
    await request.post('https://nutrious.up.railway.app/calorietracker/deletef/',
        {"id" : pk});
  }
  void deleteAll(request, nothing) async {
    await request.post('https://nutrious.up.railway.app/calorietracker/deleteAllf/',
    {"" : ""});
    
  }
  @override
  Widget build(BuildContext context) {
    final request = context.watch<CookieRequest>();
    final args = ModalRoute.of(context)!.settings.arguments as UserArguments;
    Future<List<Calorie>> fetchCalorie() async {
      final response = await request.get("https://nutrious.up.railway.app/calorietracker/show_jsonf/");
      List<Calorie> listCalorie = [];
      for (var i in response["data"]){
        if (i != null){
          listCalorie.add(Calorie.fromJson(i));
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
      body:Center(
        child: Column(
          children: [
            Expanded(
              flex: 1,
              child: Container(
                margin: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                child: Column(
                  children: [
                    const Padding(padding: EdgeInsets.all(10.0),
                      child: Text("Welcome to Calorie Tracker!", 
                        overflow: TextOverflow.ellipsis,
                        style:  TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 20
                          ),
                        ),
                    ) ,
                    
                     ElevatedButton(
                            onPressed: () {
                              showDialog(
                                  context: context,
                                  builder: (context) {
                                      return Dialog(
                                        shape: RoundedRectangleBorder(
                                          borderRadius:BorderRadius.circular(30.0)),
                                        child: SizedBox(
                                          width: 340,
                                          height: 340,
                                          child: PageView(
                                            scrollDirection: Axis.vertical,
                                            children: <Widget>[
                                              Column(
                                                // ignore: prefer_const_literals_to_create_immutables
                                                children: [
                                                  const Text( "scroll me",
                                                   style: TextStyle(color: Colors.grey, fontSize: 13,
                                                   )),
                                                const Text( "\nCalories you have\n consumed\n",
                                                overflow: TextOverflow.ellipsis,
                                                    textAlign : TextAlign.center,
                                                    style: TextStyle(
                                                        fontSize: 20,
                                                        fontWeight: FontWeight.w700,
                                                    ),
                                                ),
                                                const Icon( Icons.fastfood,
                                                                  size: 80, 
                                                 ),
                                                Text(  '\n$counterAdd kkal\n',
                                                overflow: TextOverflow.ellipsis,
                                                    textAlign : TextAlign.center,
                                                    style: const TextStyle(
                                                        fontSize: 20,
                                                        fontWeight: FontWeight.w700,
                                                    ),
                                                ),
                                                const Icon( Icons.keyboard_arrow_down, ),
                                                ],
                                            ),
                                            Column(
                                                // ignore: prefer_const_literals_to_create_immutables
                                                children: [
                                                  const Icon( Icons.keyboard_arrow_up, ),
                                                    const Text( "\nCalories you have\n burned\n",
                                                    overflow: TextOverflow.ellipsis,
                                                    textAlign : TextAlign.center,
                                                    style: TextStyle(
                                                                    fontSize: 20,
                                                                    fontWeight: FontWeight.w700,
                                                    ),
                                                ),
                                                const Icon( Icons.directions_run, 
                                                              size: 80, 
                                                              ),
                                                Text(  '\n$counterDecrease kkal\n',
                                                overflow: TextOverflow.ellipsis,
                                                    textAlign : TextAlign.center,
                                                    style: const TextStyle(
                                                        fontSize: 20,
                                                        fontWeight: FontWeight.w700,
                                                    ),
                                                ),
                                                const Icon( Icons.keyboard_arrow_down, ),
                                                ],
                                            ),
                                           
                                            Column(
                                                // ignore: prefer_const_literals_to_create_immutables
                                                children: [
                                                  const Icon( Icons.keyboard_arrow_up, ),
                                                    const Text(  "\nYour total\n accumulated calories\n",
                                                    overflow: TextOverflow.ellipsis,
                                                    textAlign : TextAlign.center,
                                                    style: TextStyle(
                                                                    fontSize: 20,
                                                                    fontWeight: FontWeight.w700,
                                                    ), 
                                                ),
                                                 Text( '\n$total kkal',
                                                 overflow: TextOverflow.ellipsis,
                                                    textAlign : TextAlign.center,
                                                    style: const TextStyle(
                                                        fontSize: 20,
                                                        fontWeight: FontWeight.w700,
                                                    ),
                                                ),
                                                Padding(padding: const  EdgeInsets.fromLTRB(0, 70, 0, 0),
                                                child: ElevatedButton(
                                                onPressed: (){
                                                Navigator.of(context).pop();
                                                  }, child: const Text("Close"))
                                              ),
                                                ],
                                            ),
                                            ],
                                            ),
                                        ),
                                      ) ;
                                  },
                              );
                            },
                            style: ElevatedButton.styleFrom(
                                padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 20.0),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10.0)
                                ),
                                backgroundColor: Colors.white
                            ),
                            child: const Text("Tap me to see\n your information\n",
                              textAlign: TextAlign.center,
                                  style: TextStyle( color: Colors.black, fontSize: 15),
                                
                               
                            ),
                          ),
                          Padding(padding: const EdgeInsets.all(10.0),
                                child: TextButton(
                                  style: ButtonStyle(
                                    backgroundColor: MaterialStateProperty.all(Colors.blue),
                                  ),
                                  child: const Text(
                                    "Delete all",
                                    style: TextStyle(color: Colors.white),
                                  ),
                                  onPressed: () {
                                    deleteAll(request, "null");
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
                     const Spacer(),
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
                                        height: 100,
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

                                          child: ListTile(
                                            title: RichText(
                                              overflow: TextOverflow.ellipsis,
                                              textAlign : TextAlign.left,
                                              text: TextSpan(
                                              style: const TextStyle(
                                                  fontSize: 20,
                                                  fontFamily: "Poppins",
                                              ),
                                              children: <TextSpan>[
                                                  TextSpan(
                                                  text: "${snapshot.data![index].category}",
                                                  
                                                  style: const TextStyle(fontWeight: FontWeight.w700,color: Colors.black),
                                                  ),
                                                  
                                                  if(!snapshot.data![index].isIncreasing)
                                                      TextSpan( 
                                                        text: hitungDecrease(snapshot.data![index].calorie),
                                                      style: const TextStyle(color: Colors.white,fontSize: 1),
                                                      ),
                                                  if(snapshot.data![index].isIncreasing)
                                                        TextSpan( 
                                                          text:hitungAdd(snapshot.data![index].calorie),
                                                        style: const TextStyle(color: Colors.white,fontSize: 1),
                                                      ),
                                                  TextSpan(  
                                                    text: hitungTotal(),
                                                  style: const TextStyle(color: Colors.white,fontSize: 1,),
                                                  ),
                                                  const TextSpan(  
                                                    text: '\nclick me to see the detail',
                                                  style: TextStyle(color: Colors.grey, fontSize: 10,
                                                  fontFamily: "Poppins",),
                                                  ),
                                              ],
                                              ),
                                          ),
                                           subtitle: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Text(DateFormat("EEEEE, yyyy-MM-dd").format(snapshot.data![index].date),
                                                overflow: TextOverflow.ellipsis,
                                                style: const TextStyle( color: Colors.grey, fontSize: 10)),
                                                ],
                                           ),
                                            trailing: Row(
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                 if(snapshot.data![index].isIncreasing)
                                                    IconButton(onPressed: () {
                                                       Navigator.push(
                                                        context,
                                                        MaterialPageRoute(builder: (context) =>EditAddCaloriePage(mycalorie: snapshot.data![index], args: args)
                                                        ),
                                                      );
                                                    }, icon: const Icon(Icons.edit)),
                                                  if(!snapshot.data![index].isIncreasing)
                                                    IconButton(onPressed: () {
                                                       Navigator.push(
                                                        context,
                                                        MaterialPageRoute(builder: (context) =>EditReduceCaloriePage(mycalorie: snapshot.data![index], args: args)
                                                        ),
                                                      );
                                                    }, icon: const Icon(Icons.edit)),
                                                  IconButton(
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
                                                    }, icon: const Icon(Icons.delete)),
                                              ],
                                            ),
                                            onTap: () {
                                             showDialog(
                                                context: context,
                                                builder: (context) {
                                                    return Dialog(
                                                      shape: RoundedRectangleBorder(
                                                        borderRadius:BorderRadius.circular(30.0)),
                                                      child: SizedBox(
                                                        height: 450,
                                                        child: Column(
                                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                          children: [
                                                            const Padding(padding: EdgeInsets.all(10.0),
                                                              child: Text("Detail",
                                                                textAlign: TextAlign.center,
                                                                style: TextStyle(
                                                                    fontSize: 20,
                                                                    fontWeight: FontWeight.w700,
                                                            ),),
                                                            ) ,
                                                            
                                                            if(snapshot.data![index].isIncreasing)
                                                              const Icon( Icons.fastfood,
                                                                  size: 80, 
                                                              ),
                                                            if(!snapshot.data![index].isIncreasing)
                                                              const Icon( Icons.directions_run, 
                                                              size: 80, 
                                                              ),
                                                            //time
                                                            RichText(
                                                              textAlign: TextAlign.center,
                                                              overflow: TextOverflow.ellipsis,
                                                                text: TextSpan(
                                                                  text: "Time added:",
                                                                  style: const TextStyle( fontFamily: "Poppins",color: Colors.black, fontSize: 15),
                                                                children: <TextSpan>[
                                                                    TextSpan(
                                                                    text: "\n${snapshot.data![index].time}",
                                                                    style: const TextStyle( fontFamily: "Poppins",fontSize: 15),
                                                                    ),
                                                                ],
                                                                ),
                                                            ),
                                                            //Calorie
                                                            RichText(
                                                              textAlign: TextAlign.center,
                                                              overflow: TextOverflow.ellipsis,
                                                                text: TextSpan(
                                                                  text: "Calorie:",
                                                                  style: const TextStyle( fontFamily: "Poppins",color: Colors.black, fontSize: 15),
                                                                children: <TextSpan>[
                                                                    TextSpan(
                                                                    text: "\n${snapshot.data![index].calorie.toString()} kkal",
                                                                    style: const TextStyle( fontFamily: "Poppins",fontWeight: FontWeight.w700, fontSize: 15),
                                                                    ),
                                                                ],
                                                                ),
                                                            ),
                                                             
                                                          const Text( "Description:",
                                                          textAlign: TextAlign.center,
                                                            style:TextStyle( fontFamily: "Poppins",color: Colors.black, fontSize: 15),
                                                          ),


                                                            // Description
                                                            Container(
                                                                padding: const EdgeInsets.all(3.0),
                                                                height:75,
                                                                width:100,
                                                                
                                                                  child: SingleChildScrollView(
                                                                    scrollDirection: Axis.vertical,
                                                                    child: 
                                                                      Text( "\n${snapshot.data![index].description}",
                                                                      textAlign: TextAlign.center,
                                                                      style: const TextStyle( fontFamily: "Poppins", fontSize: 15, decoration: TextDecoration.underline),
                                                                      ),
                                                                    ),
                                                                ),
                                                              
                                                            Padding(padding: const EdgeInsets.all(10.0),
                                                              child: ElevatedButton(
                                                              onPressed: (){
                                                              Navigator.of(context).pop();
                                                                }, child: const Text("Close"))
                                                          ),
                                                          ],
                                                        ),
                                                      ),
                                                    ) ;
                                                
                                                },
                                            );
                                            }
                                        
                                        )
                                    )
                                  );
                                }
                              }
                            },
                          ),
                        ),
                      Container(
                      margin: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                        child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Padding(padding: const EdgeInsets.all(10.0),                
                              child: TextButton(
                                style: ButtonStyle(
                                  backgroundColor: MaterialStateProperty.all(Colors.blue),
                                ),
                                child: const Text(
                                  "Add Calorie",
                                  style: TextStyle(color: Colors.white),
                                ),
                                onPressed: () {
                                  Navigator.push(context,
                                      MaterialPageRoute(builder: (context) =>
                                          AddCaloriePage(args: args)));
                                  },
                                ),
                              ),
                              Padding(padding: const EdgeInsets.all(10.0),
                                child: TextButton(
                                  style: ButtonStyle(
                                    backgroundColor: MaterialStateProperty.all(Colors.blue),
                                  ),
                                  child: const Text(
                                    "Reduce Calorie",
                                    style: TextStyle(color: Colors.white),
                                  ),
                                  onPressed: () {
                                    Navigator.push(context,
                                        MaterialPageRoute(builder: (context) =>
                                            ReduceCaloriePage(args: args)));
                                  },
                                ),
                              ),
                               
                              ],
                            )
                          ),
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
