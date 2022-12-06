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
  int counter_add = 0;
  int counter_decrease = 0;
  int total =0;
 hitung_add(int x){
    counter_add += x;
    return counter_add.toString();
  }
 hitung_decrease(int x){
   print("tets");
    counter_decrease += x;
    return counter_decrease.toString();
  }
 hitung_total(){
   print("tets");
    total = counter_add-counter_decrease;
    return total.toString();
  }
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
      body:Center(
        child: Column(
          children: [
            Expanded(
              flex: 1,
              child: Container(
                margin: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                child: Column(
                  children: [
                    Text("Welcome to Calorie Tracker, ${args.nickname} !", 
                    style: TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 30
                      ),
                    ),
                    Text("\nThis is your calorie tracker for today\n",
                    style: TextStyle(
                      fontSize: 15
                      ),
                    ),
                     Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        ElevatedButton(
                          onPressed: () {
                            showDialog(
                                context: context,
                                builder: (context) {
                                    return Dialog(
                                      shape: RoundedRectangleBorder(
                                        borderRadius:BorderRadius.circular(30.0)),
                                      child: Container(
                                        height: 150,
                                        child: Column(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text( "Calories you have\n consumed:\n",
                                             textAlign : TextAlign.center,
                                            ),
                                            Text( '$counter_add',
                                            style: TextStyle(fontWeight: FontWeight.w700,)
                                            ),  
                                            ElevatedButton(
                                            onPressed: (){
                                            Navigator.of(context).pop();
                                              }, child: Text("Close"))
                                          ],
                                        ),
                                      ),
                                    ) ;
                                },
                            );
                          },
                          style: ElevatedButton.styleFrom(
                              padding: EdgeInsets.symmetric(horizontal: 30.0, vertical: 30.0),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10.0)
                              ),
                              primary: Colors.white
                          ),
                          child: RichText(
                            textAlign: TextAlign.center,
                            overflow: TextOverflow.ellipsis,
                              text: TextSpan(
                                text: "Calories you have\n consumed\n",
                                style: TextStyle( fontFamily: "Poppins",color: Colors.black, fontSize: 15),
                              children: <TextSpan>[
                                  TextSpan(
                                  text: "click to see it",
                                  style: TextStyle( fontFamily: "Poppins",color: Colors.grey, fontSize: 10),
                                  ),
                              ],
                              ),
                          ),
                         ),
                        ElevatedButton(
                          onPressed: () {
                              showDialog(
                                context: context,
                                builder: (context) {
                                    return Dialog(
                                      shape: RoundedRectangleBorder(
                                        borderRadius:BorderRadius.circular(30.0)),
                                      child: Container(
                                        height: 150,
                                        child: Column(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text( "Calories you have\n burned:\n ",
                                            textAlign : TextAlign.center,
                                            ),
                                             Text( '$counter_decrease',
                                             style: TextStyle(fontWeight: FontWeight.w700,)
                                             ),
                                            ElevatedButton(
                                            onPressed: (){
                                            Navigator.of(context).pop();
                                              }, child: Text("Close"))
                                          ],
                                        ),
                                      ),
                                    ) ;
                                },
                            );
                          },
                          style: ElevatedButton.styleFrom(
                              padding: EdgeInsets.symmetric(horizontal: 30.0, vertical: 30.0),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10.0)
                              ),
                              primary: Colors.white
                          ),
                          child: RichText(
                            textAlign: TextAlign.center,
                            overflow: TextOverflow.ellipsis,
                              text: TextSpan(
                                text: "Calories you have\n burned\n ",
                                style: TextStyle(  fontFamily: "Poppins",color: Colors.black, fontSize: 15),
                              children: <TextSpan>[
                                  TextSpan(
                                  text: "click to see it",
                                  style: TextStyle(  fontFamily: "Poppins",color: Colors.grey, fontSize: 10),
                                  ),
                              ],
                              ),
                          ),
                        ),
                        ElevatedButton(
                          onPressed: () {
                              showDialog(
                                context: context,
                                builder: (context) {
                                    return Dialog(
                                      shape: RoundedRectangleBorder(
                                        borderRadius:BorderRadius.circular(30.0)),
                                      child: Container(
                                        height: 150,
                                        child: Column(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text( "Your total\n accumulated calories:\n",
                                            textAlign: TextAlign.center,),
                                            Text( '$total',
                                            style: TextStyle(fontWeight: FontWeight.w700,),
                                            ),
                                            ElevatedButton(
                                            onPressed: (){
                                            Navigator.of(context).pop();
                                              }, child: Text("Close"))
                                          ],
                                        ),
                                      ),
                                    ) ;
                                },
                            );
                          },
                          style: ElevatedButton.styleFrom(
                              padding: EdgeInsets.symmetric(horizontal: 30.0, vertical: 30.0),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10.0)
                              ),
                              primary: Colors.white
                          ),
                          child: 
                          RichText(
                            textAlign: TextAlign.center,
                            overflow: TextOverflow.ellipsis,
                              text: TextSpan(
                                text: "Your total\n accumulated calories\n",
                                style: TextStyle(  fontFamily: "Poppins",color: Colors.black, fontSize: 15),
                              children: <TextSpan>[
                                  TextSpan(
                                  text: "click to see it",
                                  style: TextStyle(  fontFamily: "Poppins",color: Colors.grey, fontSize: 10),
                                  ),
                              ],
                              ),
                          ),
                        ),
                      ],
                     ),
                     Spacer(),
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

                                          child: ListTile(
                                            title: RichText(
                                              textAlign : TextAlign.left,
                                              text: TextSpan(
                                              style: const TextStyle(
                                                  fontSize: 25,
                                                  fontFamily: "Poppins",
                                              ),
                                              children: <TextSpan>[
                                                  TextSpan(
                                                  text: "${snapshot.data![index].category}",
                                                  style: TextStyle(fontWeight: FontWeight.w700,),
                                                  ),
                                                  if(!snapshot.data![index].isIncreasing)
                                                      TextSpan( 
                                                        text: hitung_decrease(snapshot.data![index].calorie),
                                                      style: TextStyle(color: Colors.white),
                                                      ),
                                                  if(snapshot.data![index].isIncreasing)
                                                        TextSpan( 
                                                          text:hitung_add(snapshot.data![index].calorie),
                                                        style: TextStyle(color: Colors.white),
                                                      ),
                                                  TextSpan(  
                                                    text: hitung_total(),
                                                  style: TextStyle(color: Colors.white),
                                                  ),
                                                  TextSpan(  
                                                    text: '\nclick me to see the detail',
                                                  style: TextStyle(color: Colors.grey, fontSize: 10,
                                                  fontFamily: "Poppins",),
                                                  ),
                                              ],
                                              ),
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
                                                      child: Container(
                                                        height: 300,
                                                        child: Column(
                                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                          children: [
                                                            Text("Detail",
                                                                textAlign: TextAlign.center,
                                                                style: const TextStyle(
                                                                    fontSize: 30,
                                                                    fontWeight: FontWeight.w700,
                                                            ),),
                                                            //Calorie
                                                             Text("Calorie: ${snapshot.data![index].calorie.toString()}",
                                                                textAlign: TextAlign.left,
                                                                overflow: TextOverflow.ellipsis,
                                                                style: const TextStyle(
                                                                    fontSize: 15
                                                                ),),
                                                          

                                                            // Description
                                                            Text("Description: ${snapshot.data![index].description} " ,
                                                                textAlign: TextAlign.left,
                                                                overflow: TextOverflow.ellipsis,
                                                                style: const TextStyle(
                                                                    fontSize: 15
                                                                ),),
                                                            ElevatedButton(
                                                            onPressed: (){
                                                            Navigator.of(context).pop();
                                                              }, child: Text("Close"))
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
