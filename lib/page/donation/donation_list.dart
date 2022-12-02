import 'package:flutter/material.dart';
import 'package:nutrious/page/donation/donation_detail.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:provider/provider.dart';
import 'package:nutrious/model/fundraising.dart';
import 'package:nutrious/util/curr_converter.dart';
import '../../model/user_data.dart';
import '../home/drawer.dart';

class DonationList extends StatefulWidget {
  const DonationList({Key? key}) : super(key: key);

  @override
  State<DonationList> createState() => _DonationListState();
}

class _DonationListState extends State<DonationList> {
  @override
  Widget build(BuildContext context) {
    final request = context.watch<CookieRequest>();
    Future<List<Fundraising>> fetchDonation() async {
      final response = await request.get("https://nutrious.up.railway.app/donation/json-verified/");
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
      body: Center(
        child: Column(
          children: [
            Expanded(
              flex: 1,
              child: Container(
                margin: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                child: const Text("Please click the respective donation(s) to go \n to the detail page and donate", style: TextStyle(
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
                            child: InkWell(
                              onTap: (){
                                Navigator.push(context, MaterialPageRoute(builder: (context) =>
                                    DonationDetail(detail: snapshot.data![index])));
                              },
                              child: Column(
                                children: [
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
                                  Expanded(
                                    flex: 1,
                                    child: Align(
                                        alignment: Alignment.topLeft,
                                        child: Text("Opened by ${snapshot.data![index].opener}")),
                                  ),
                                  Expanded(
                                    flex: 1,
                                    child: Row(
                                      children: [
                                        Expanded(
                                          flex: 7,
                                          child: Text(CurrencyFormat.convertToIdr(snapshot.data![index].amountNeeded, 2)),
                                        ),
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
