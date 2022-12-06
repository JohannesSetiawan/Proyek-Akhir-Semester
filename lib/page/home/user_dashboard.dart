import 'package:flutter/material.dart';
import 'package:nutrious/page/home/drawer.dart';
import 'package:nutrious/model/user_data.dart';
import 'package:provider/provider.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';

class UserDashboard extends StatefulWidget {
  const UserDashboard({Key? key}) : super(key: key);

  @override
  State<UserDashboard> createState() => _UserDashboardState();
}

class _UserDashboardState extends State<UserDashboard> {
  // String message = "";
  final _formKey = GlobalKey<FormState>();
  bool isLoading = false;
  TextEditingController message = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final request = context.watch<CookieRequest>();
    final args = ModalRoute.of(context)!.settings.arguments as UserArguments;
    return Scaffold(
      resizeToAvoidBottomInset: false,
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
      body: ListView(
            children: [
              Center(
                child: Container(
                  padding: const EdgeInsets.all(5),
                  margin: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                  child: RichText(
                    textAlign: TextAlign.center,
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
                          text: args.nickname,
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
              ),
              Container(
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
              Container(
                margin: const EdgeInsets.all(5),
                padding: const EdgeInsets.all(5),
                child: Column(
                  children: [
                    const Text("Leave a Message for Our Administrator",
                        style: TextStyle(fontWeight: FontWeight.w700)),
                    const SizedBox(height: 8),
                    Form(
                      key: _formKey,
                      child: Row(
                        children: [
                          Expanded(
                            flex: 8,
                            child: TextFormField(
                              controller: message,
                              decoration: const InputDecoration(
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.all(Radius.circular(10))
                                ),
                                contentPadding: EdgeInsets.fromLTRB(8, 2, 8, 2),
                                hintText: "Message",
                              ),
                              onSaved: (String? value){
                                setState(() {
                                  message.text = value!;
                                  message.selection = TextSelection.collapsed(offset: message.text.length);
                                });
                              },
                              onChanged: (String? value){
                                setState(() {
                                  message.text = value!;
                                  message.selection = TextSelection.collapsed(offset: message.text.length);
                                });
                              },
                                validator: (String? value){
                                  if (value == null || value.isEmpty){
                                    return 'Please fill the message field';
                                  }
                                  return null;
                                }
                            ),
                          ),
                          !isLoading ? IconButton(
                            icon: const Icon(Icons.send, color: Colors.indigo,),
                            onPressed: () async {
                              if (_formKey.currentState!.validate()) {
                                setState((){
                                  isLoading=true;
                                });
                                final response = await request.post(
                                  "https://nutrious.up.railway.app/add-message/",
                                {
                                  "message": message.text
                                }).timeout(const Duration(seconds: 10),
                                    onTimeout: () {
                                    setState((){
                                      isLoading=false;
                                    });
                                    showDialog(context: context, builder: (context) {
                                      return AlertDialog(
                                        shape: const RoundedRectangleBorder(
                                            borderRadius: BorderRadius.all(Radius.circular(15.0))
                                        ),
                                        title: const Text("Error", style: TextStyle(
                                          fontWeight: FontWeight.w700,
                                        ),),
                                        content: const Text("Failed to send message. Please check your internet connection."),
                                        actions: <Widget>[
                                          TextButton(
                                            onPressed: () {
                                              Navigator.of(context).pop();
                                            },
                                            child: Container(
                                              padding: const EdgeInsets.all(5),
                                              child: const Text("Close", style: TextStyle(
                                                fontWeight: FontWeight.w700,
                                              ),),
                                            ),
                                          ),
                                        ],
                                      );
                                    });
                                });
                                setState((){
                                  isLoading=false;
                                });
                                if (response != null){
                                  message.clear();
                                  showDialog(context: context, builder: (context) {
                                    return AlertDialog(
                                      shape: const RoundedRectangleBorder(
                                          borderRadius: BorderRadius.all(Radius.circular(15.0))
                                      ),
                                      content: Text(response["status"]),
                                      actions: <Widget>[
                                        TextButton(
                                          onPressed: () {
                                            Navigator.of(context).pop();
                                          },
                                          child: Container(
                                            padding: const EdgeInsets.all(5),
                                            child: const Text("Close", style: TextStyle(
                                              fontWeight: FontWeight.w700,
                                            ),),
                                          ),
                                        ),
                                      ],
                                    );
                                  });
                                }
                              }
                            },) :  Container(
                                  margin: const EdgeInsets.all(5),
                                  child: const CircularProgressIndicator()),
                        ],
                      ),
                    )
                  ],
                ),
              ),
              const Center(
                child: Text("Explore Our Features", style: TextStyle(
                  fontWeight: FontWeight.w700
                ),),
              ),
              Container(
                  margin: const EdgeInsets.all(5),
                  child: Column(
                    children: [
                      Container(
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
                        padding: const EdgeInsets.all(10),
                        margin: const EdgeInsets.all(5),
                        height: 50,
                        child: InkWell(
                          child: const Center(
                            child: Text("Fundraising",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontWeight: FontWeight.w700
                            ),),
                          ),
                          onTap: () {

                          },
                        ),
                      ),
                      const SizedBox(height: 5,),
                      Container(
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
                        padding: const EdgeInsets.all(10),
                        margin: const EdgeInsets.all(5),
                        height: 50,
                        child: InkWell(
                          child: const Center(
                            child: Text("Food-Sharing",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontWeight: FontWeight.w700
                              ),),
                          ),
                          onTap: (){
                            // insert navigator
                          },
                        ),
                      ),
                      const SizedBox(height: 5,),
                      Container(
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
                        padding: const EdgeInsets.all(10),
                        margin: const EdgeInsets.all(5),
                        height: 50,
                        child: InkWell(
                          child: const Center(
                            child: Text("Calorie Tracker",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontWeight: FontWeight.w700
                              ),),
                          ),
                          onTap: (){
                            // insert navigator
                          },
                        ),
                      ),
                      const SizedBox(height: 5,),
                      Container(
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
                        padding: const EdgeInsets.all(10),
                        margin: const EdgeInsets.all(5),
                        height: 50,
                        child: InkWell(
                          child: const Center(
                            child: Text("Food Recipes",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontWeight: FontWeight.w700
                              ),),
                          ),
                          onTap: (){
                            // insert navigator
                          },
                        ),
                      ),
                      const SizedBox(height: 5,),
                      Container(
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
                        padding: const EdgeInsets.all(10),
                        margin: const EdgeInsets.all(5),
                        height: 50,
                        child: InkWell(
                          child: const Center(
                            child: Text("Blog",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontWeight: FontWeight.w700
                              ),),
                          ),
                          onTap: (){
                            // insert navigator
                          },
                        ),
                      )
                    ],
                  ),
                ),

            ],
          ),
    );}
}
