import 'package:firebase_tut/screens/phone.dart';
import 'package:firebase_tut/uiWidgets.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
        body: SingleChildScrollView(
      child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.25,
            ),
            Container(
              child: Image.asset('assets/images/image@2x.png'),
            ),
            Center(
                child: UiHelper.customizeText('Please select your Language')),
            Center(
                child: UiHelper.customizeTextSmall(
              'You can change the language at any time.',
            )),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.03,
            ),
            Container(
              alignment: Alignment.center,
              width: 216,
              height: 48,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  UiHelper.customizeTextButton('English'),
                  IconButton(
                      onPressed: () {}, icon: Icon(Icons.arrow_drop_down))
                ],
              ),
              decoration: BoxDecoration(
                  color: Colors.blue.withOpacity(0.0), // Transparent blue
                  border: Border.all(
                      width: 1, color: Color.fromRGBO(47, 48, 55, 1))),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.03,
            ),
            UiHelper.customizeTextCB(
                onPressed: () {
                  Get.to(PhonePage());
                },
                text: 'Next',
                width: 216,
                height: 48),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.26,
            ),
            Container(
              width: screenWidth,
              child: Stack(
                children: [
                  Image.asset(
                    width: screenWidth,
                    'assets/images/p2.png',
                    fit: BoxFit.fill,
                  ),
                  Image.asset(
                    width: screenWidth,
                    'assets/images/p1.png',
                    fit: BoxFit.fill,
                  ),
                ],
              ),
            )
          ]),
    ));
  }
}
