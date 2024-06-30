import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_tut/screens/otp.dart';
import 'package:firebase_tut/uiWidgets.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PhonePage extends StatefulWidget {
  const PhonePage({super.key});

  @override
  State<PhonePage> createState() => _PhonePageState();
}

class _PhonePageState extends State<PhonePage> {
  TextEditingController controller = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
          leading: IconButton(
              onPressed: () => Get.back(),
              icon: Icon(
                Icons.close,
                size: 32,
              ))),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.1,
            ),
            Center(
              child: UiHelper.customizeText(
                "Please enter your mobile number",
              ),
            ),
            Center(
              child: UiHelper.customizeTextSmall(
                'You’ll receive a 4 digit code\nto verify next.',
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.03,
            ),
            Container(
              alignment: Alignment.center,
              width: 328,
              height: 56,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 10),
                child: Row(
                  //  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Image.asset('assets/images/india 2.png'),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 15),
                      child: UiHelper.customizeTextCountry('+91'),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      child: UiHelper.customizeTextCountry('-'),
                    ),
                    Expanded(
                      child: TextField(
                        controller: controller,
                        decoration: InputDecoration(
                          hintText: 'Mobile number',
                          border: InputBorder.none,
                          isDense: true, // Reduce the height of the text field
                          contentPadding: EdgeInsets
                              .zero, // Remove padding inside the text field
                        ),
                        keyboardType: TextInputType.phone,
                        style: TextStyle(
                          fontFamily: 'Roboto', // Use the Roboto font
                          fontWeight: FontWeight.w400,
                          fontSize: 16,
                        ),
                      ),
                    )
                  ],
                ),
              ),
              decoration: BoxDecoration(
                color: Colors.blue.withOpacity(0.0), // Transparent blue
                border: Border.all(
                  width: 1,
                  color: Color.fromRGBO(47, 48, 55, 1),
                ),
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.032,
            ),
            UiHelper.customizeTextCB(
                text: 'Continue',
                width: 328,
                height: 56,
                onPressed: () async {
                  String phoneNumber = '+91${controller.text.trim()}';
                  await FirebaseAuth.instance.verifyPhoneNumber(
                      verificationCompleted:
                          (PhoneAuthCredential credential) {},
                      verificationFailed: (FirebaseAuthException ex) {},
                      codeSent: (String verficationid, int? resendtoken) {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => OtpPage(
                                      verificationid: verficationid,
                                      phone: controller.text.toString(),
                                    )));
                      },
                      codeAutoRetrievalTimeout: (String verificationId) {},
                      phoneNumber: phoneNumber);
                }),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.322,
            ),
            Image.asset(
              'assets/images/p4.png',
              width: screenWidth,
              fit: BoxFit.fill,
            ),
          ],
        ),
      ),
    );
  }
}
