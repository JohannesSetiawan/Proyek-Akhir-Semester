import 'package:flutter/material.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:provider/provider.dart';
import 'package:nutrious/model/fundraising.dart';

class FundraisingList extends StatefulWidget {
  const FundraisingList({Key? key}) : super(key: key);

  @override
  State<FundraisingList> createState() => _FundraisingListState();
}

class _FundraisingListState extends State<FundraisingList> {
  @override
  Widget build(BuildContext context) {
    final request = context.watch<CookieRequest>();
    Future<List<Fundraising>> fetchDonation() async {
      final response = await request.get("https://nutrious.up.railway.app/donation/json/");
      List<Fundraising> listFundraising = [];
      for (var fundraising in response){
        if (fundraising != null){
          listFundraising.add(Fundraising.fromJson(fundraising));
        }
      }
      return listFundraising;
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
                child: const Text("List of Fundraising(s)", style: TextStyle(
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
                            child: Column(
                              children: [
                                Expanded(
                                  flex: 2,
                                  child: Align(
                                    alignment: Alignment.topLeft,
                                    child: Text(snapshot.data![index].fields.name, textAlign: TextAlign.left, style: const TextStyle(
                                        fontWeight: FontWeight.w700,
                                        fontSize: 20
                                    ),),
                                  ),
                                ),
                                Expanded(
                                  flex: 1,
                                  child: Row(
                                    children: [
                                      Expanded(
                                        flex: 7,
                                        child: Text("Opener ID: ${snapshot.data![index].fields.opener.toString()}"),
                                      ),
                                      Expanded(
                                        flex: 3,
                                        child: snapshot.data![index].fields.isVerified ?
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
