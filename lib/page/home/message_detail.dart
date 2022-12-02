// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

String formatDateTime(datetime) {
  final outputFormat = DateFormat("dd MMMM yyyy, HH:mm");
  return outputFormat.format(datetime);
}

class MessageDetail extends StatelessWidget {
  final detail;
  const MessageDetail({Key? key, required this.detail}) : super(key: key);

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
                  const Text("Message", style: TextStyle(
                      fontSize: 16
                  ),),
                  Text(detail.message,
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
                  const Text("Message ID", style: TextStyle(
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
                  const Text("Sender", style: TextStyle(
                      fontSize: 16
                  ),),
                  Text(detail.sender,
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
                  const Text("Time Sent", style: TextStyle(
                      fontSize: 16
                  ),),
                  Text(formatDateTime(detail.time.toLocal()),
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 18
                    ),)
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
