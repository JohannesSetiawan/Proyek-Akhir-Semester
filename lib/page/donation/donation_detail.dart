// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';
import 'package:nutrious/util/curr_converter.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:provider/provider.dart';
import 'donation_list.dart';

double getPercentage(needed, collected){
  if (collected >= needed) {
    return 1.0;
  } else {
    return collected/needed;
  }
}

int getRemaining(needed, collected){
  if (collected >= needed) {
    return 0;
  } else {
    return needed-collected;
  }
}

class DonationDetail extends StatefulWidget {
  final detail;

  const DonationDetail({super.key, required this.detail});

  @override
  State<DonationDetail> createState() => _DonationDetailState();
}

class _DonationDetailState extends State<DonationDetail> {
  final _formKey = GlobalKey<FormState>();
  String nominal = "";

  bool isNumeric(String value){
    if(value == null) {
      return false;
    }
    return int.tryParse(value) != null;
  }

  void donate(request, id, nominal) async {
    String pk = id.toString();
    var response = await request.post('https://nutrious.up.railway.app/donation/donate/',
        {"amount": nominal, "id": pk});
  }

  @override
  Widget build(BuildContext context) {
    final request = context.watch<CookieRequest>();
    final detail = widget.detail;
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
        child: ListView(
          children: [
            Container(
              margin: const EdgeInsets.all(15),
              child: const Text("Detail", textAlign: TextAlign.center, style: TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: 25,
              ),),
            ),
            Container(
              margin: const EdgeInsets.all(10),
              padding: const EdgeInsets.all(5),
              child: Column(
                children: [
                  const Text("Title", style: TextStyle(
                      fontSize: 16
                  ),),
                  Text(detail.name,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 18
                    ),)
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.all(10),
              padding: const EdgeInsets.all(5),
              child: Column(
                children: [
                  const Text("Donation ID", style: TextStyle(
                      fontSize: 16
                  ),),
                  Text(detail.pk.toString(),
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 18
                    ),)
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.all(10),
              padding: const EdgeInsets.all(5),
              child: Column(
                children: [
                  const Text("Opener", style: TextStyle(
                      fontSize: 16
                  ),),
                  Text(detail.opener,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 18
                    ),)
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.all(10),
              padding: const EdgeInsets.all(5),
              child: Column(
                children: [
                  const Text("Description", style: TextStyle(
                      fontSize: 16
                  ),),
                  Text(detail.description,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 18
                    ),)
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.all(10),
              padding: const EdgeInsets.all(5),
              child: Column(
                children: [
                  const Text("Amount Needed", style: TextStyle(
                      fontSize: 16
                  ),),
                  Text(CurrencyFormat.convertToIdr(detail.amountNeeded, 2),
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 18
                    ),)
                ],
              ),
            ),
              Container(
                margin: const EdgeInsets.all(10),
                padding: const EdgeInsets.all(5),
                child: Column(
                  children: [
                    const Text("Collected Funds", style: TextStyle(
                        fontSize: 16
                    ),),
                    Text(CurrencyFormat.convertToIdr(detail.collectedFunds, 2),
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 18
                      ),)
                  ],
                ),
              ),
              Container(
                margin: const EdgeInsets.all(10),
                padding: const EdgeInsets.all(5),
                child: Column(
                  children: [
                    const Text("Remaining Amount", style: TextStyle(
                        fontSize: 16
                    ),),
                    Text(CurrencyFormat.convertToIdr(getRemaining(detail.amountNeeded, detail.collectedFunds), 2),
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 18
                      ),)
                  ],
                ),
              ),
              Container(
                margin: const EdgeInsets.all(10),
                padding: const EdgeInsets.all(5),
                child: Column(
                  children: [
                    const Text("Percentage", style: TextStyle(
                        fontSize: 16
                    ),),
                    LinearPercentIndicator(
                      lineHeight: 20,
                      percent: getPercentage(detail.amountNeeded, detail.collectedFunds),
                      backgroundColor: const Color(0xFFD3D3D3),
                      progressColor: Colors.indigo,
                      center: Text("${getPercentage(detail.amountNeeded, detail.collectedFunds)*100}%", style: const TextStyle(
                        fontWeight: FontWeight.w700
                      ),),
                      animation: true,
                      animationDuration: 2500,
                    )
                  ],
                ),
              ),
              Container(
                margin: const EdgeInsets.all(10),
                padding: const EdgeInsets.all(5),
                child: Column(
                  children: [
                    const Text("Donate", style: TextStyle(
                        fontSize: 16
                    ),),
                    Form(
                      key: _formKey,
                      child: SingleChildScrollView(
                        child: Container(
                          padding: const EdgeInsets.all(20.0),
                          child: Column(
                            children: [
                              // Donate amount
                              SizedBox(
                                width: 300,
                                height: 60,
                                child: TextFormField(
                                  decoration: InputDecoration(
                                    hintText: "Example: 100000",
                                    labelText: "Amount",
                                    // Menambahkan icon
                                    icon: const Icon(Icons.attach_money),
                                    // Menambahkan circular border
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(5.0),
                                    ),
                                  ),

                                  keyboardType: TextInputType. number,

                                  // Menambahkan behavior saat kolom nominal diisi
                                  onChanged: (String? value) {
                                    setState(() {
                                      nominal = value!;
                                    });
                                  },
                                  // Menambahkan behavior saat data disimpan
                                  onSaved: (String? value) {
                                    setState(() {
                                      nominal = value!;
                                    });
                                  },
                                  // Validator sebagai validasi form
                                  validator: (String? value) {

                                    // Saat kosong
                                    if (value == null || value.isEmpty) {
                                      return 'Please fill this field out';
                                    }

                                    // Saat bukan angka
                                    if (!isNumeric(value)) {
                                      return 'Please make sure you inserted a number into this field';
                                    }
                                    return null;
                                  },
                                ),
                              ),

                              TextButton(
                                child: const Text(
                                  "Donate now",
                                  style: TextStyle(color: Colors.white),
                                ),
                                style: ButtonStyle(
                                  backgroundColor: MaterialStateProperty.all(Colors.blue),
                                ),
                                onPressed: () async {
                                  if (_formKey.currentState!.validate()) {
                                    donate(request, detail.pk , nominal);
                                    print(nominal);
                                    Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(builder: (context) => const DonationList()),
                                    );
                                  }
                                },
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
            ),
          ],
        ),
      ),
    );
  }
}
