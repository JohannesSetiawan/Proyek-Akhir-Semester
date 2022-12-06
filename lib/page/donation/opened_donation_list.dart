import 'package:flutter/material.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:provider/provider.dart';
import 'package:nutrious/model/fundraising.dart';
import 'package:nutrious/util/curr_converter.dart';
import '../home/drawer.dart';

class OpenedDonationList extends StatefulWidget {
  final dynamic args;
  const OpenedDonationList({Key? key, required this.args}) : super(key: key);

  @override
  State<OpenedDonationList> createState() => _OpenedDonationListState();
}

class _OpenedDonationListState extends State<OpenedDonationList> {

  delete(request, id) async {
    String pk = id.toString();
    var response = await request.post('https://nutrious.up.railway.app/donation/close/',
        {"id" : pk});
    return response;
  }

  @override
  Widget build(BuildContext context) {
    final request = context.watch<CookieRequest>();
    final args = widget.args;
    Future<List<Fundraising>> fetchDonation() async {
      final response = await request.get("https://nutrious.up.railway.app/donation/json-by-user/");
      List<Fundraising> listDonation = [];
      for (var fundraising in response["data"]){
        if (fundraising != null){
          listDonation.add(Fundraising.fromJson(fundraising));
        }
      }
      return listDonation;
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
                child: const Text("List of Your Opened Donation(s)", style: TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 20
                ),),
              ),
            ),
            Expanded(
              flex: 10,
              child: FutureBuilder(
                future: fetchDonation(),
                builder: (context, AsyncSnapshot snapshot){
                  if (snapshot.data == null){
                    return const Center(child: CircularProgressIndicator());
                  } else{
                    if (!snapshot.hasData) {
                      return const Text("No Opened Fundraising");
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
                                      child: Text(snapshot.data![index].name,
                                        textAlign: TextAlign.left,
                                        overflow: TextOverflow.ellipsis,
                                        style: const TextStyle(
                                            fontWeight: FontWeight.w700,
                                            fontSize: 20
                                        ),),
                                    ),
                                  ),

                                  //Description
                                  Expanded(
                                    flex: 1,
                                    child: Align(
                                      alignment: Alignment.topLeft,
                                      child:Flexible(
                                        child: Text(snapshot.data![index].description,
                                        textAlign: TextAlign.left,
                                        overflow: TextOverflow.ellipsis,
                                        style: const TextStyle(
                                            fontWeight: FontWeight.w700,
                                            fontSize: 10
                                        ),),)
                                    ),
                                  ),

                                  //Amount needed
                                  Expanded(
                                    flex: 1,
                                    child: Align(
                                      alignment: Alignment.topLeft,
                                      child: Text("Amount Needed: ${CurrencyFormat.convertToIdr(snapshot.data![index].amountNeeded, 2)}",
                                        textAlign: TextAlign.left,
                                        overflow: TextOverflow.ellipsis,
                                        style: const TextStyle(
                                            fontWeight: FontWeight.w700,
                                            fontSize: 15
                                        ),),
                                    ),
                                  ),

                                  // Collected
                                  Expanded(
                                    flex: 1,
                                    child: Align(
                                      alignment: Alignment.topLeft,
                                      child: Text("Collected: ${snapshot.data![index].collectedFunds}",
                                        textAlign: TextAlign.left,
                                        overflow: TextOverflow.ellipsis,
                                        style: const TextStyle(
                                            fontWeight: FontWeight.w700,
                                            fontSize: 15
                                        ),),
                                    ),
                                  ),

                                  //Verification Status
                                  Expanded(
                                    flex: 1,
                                    child: snapshot.data![index].isVerified ?
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
                                  ),

                                  // Button for close donation
                                  Expanded(
                                    flex: 1,
                                    child: Align(
                                      alignment: Alignment.topLeft,
                                      child: TextButton(
                                        style: ButtonStyle(
                                          backgroundColor: MaterialStateProperty.all(Colors.red),
                                        ),
                                        onPressed: () {
                                          delete(request, snapshot.data![index].pk);
                                          Navigator.push(context,
                                              MaterialPageRoute(builder: (context) =>
                                                  OpenedDonationList(args: args)));
                                        },
                                        child: const Text(
                                          "Close donation",
                                          style: TextStyle(color: Colors.white),
                                        ),
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
    );
  }
}
