import 'package:flutter/material.dart';
import 'package:nutrious/util/curr_converter.dart';
import 'package:percent_indicator/percent_indicator.dart';

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

class FundraisingDetail extends StatelessWidget {
  final detail;
  const FundraisingDetail({Key? key, required this.detail}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
            detail.isVerified ?
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
              ):
              // if the donation is not verified yet, "collected funds" will not appear
              Container(),
            detail.isVerified ?
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
              ):
              // if the donation is not verified yet, "remaining amount" will not appear
              Container(),
            detail.isVerified ?
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
              ):
              // if the donation is not verified yet, "collected funds" will not appear
              Container(),
              Container(
                margin: const EdgeInsets.all(10),
                padding: const EdgeInsets.all(5),
                child: Column(
                  children: [
                    const Text("Status", style: TextStyle(
                        fontSize: 16
                    ),),
                    detail.isVerified? const Text("Verified",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 18,
                          color: Colors.green
                      ),) : const Text("Not Verified",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 18,
                          color: Colors.red
                      ),)
                  ],
                ),
              )
          ],
        ),
      ),
    );
  }
}
