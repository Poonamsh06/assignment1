// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sms_autofill/sms_autofill.dart';

import 'package:firebase_tut/screens/profile.dart';
import 'package:firebase_tut/uiWidgets.dart';

class OtpPage extends StatefulWidget {
  String verificationid;
  final phone;
  OtpPage({
    Key? key,
    required this.verificationid,
    required this.phone,
  }) : super(key: key);

  @override
  State<OtpPage> createState() => _OtpPageState();
}

class _OtpPageState extends State<OtpPage> {
  TextEditingController otpController = TextEditingController();

  String? otpCode;

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Get.back(),
          icon: const Icon(
            Icons.close,
            size: 32,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.1,
            ),
            Center(child: UiHelper.customizeText('Verify Code')),
            Center(
              child: UiHelper.customizeTextSmall(
                'Code is sent to ${widget.phone}',
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.03,
            ),
            Center(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: PinFieldAutoFill(
                  controller: otpController,
                  currentCode: otpCode,
                  codeLength: 6,
                  onCodeChanged: (code) {
                    WidgetsBinding.instance!.addPostFrameCallback((_) {
                      setState(() {
                        otpCode = code;
                      });
                    });
                  },
                  decoration: BoxLooseDecoration(
                    strokeColorBuilder:
                        FixedColorBuilder(Color.fromRGBO(147, 210, 243, 1)),
                    textStyle: TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                    bgColorBuilder:
                        FixedColorBuilder(Color.fromRGBO(147, 210, 243, 1)),
                    obscureStyle: ObscureStyle(isTextObscure: false),
                    gapSpace: 10.0,
                    radius: Radius.circular(0.0),
                    // Corrected here
                  ),
                ),
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.02,
            ),
            UiHelper.customizeRichText(),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.025,
            ),
            UiHelper.customizeTextCB(
              text: 'Verify and Continue',
              width: 328,
              height: 56,
              onPressed: () async {
                try {
                  PhoneAuthCredential credential = PhoneAuthProvider.credential(
                    verificationId: widget.verificationid,
                    smsCode: otpController.text.toString(),
                  );

                  final authResult = await FirebaseAuth.instance
                      .signInWithCredential(credential);
                  if (authResult.user != null) {
                    Get.to(ProfilePage());
                  } else {
                    // Handle scenario where user authentication failed
                    log('User authentication failed.');
                  }
                } catch (ex) {
                  log('Error signing in: $ex');
                  // Handle specific exceptions here if needed
                }
              },
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.306,
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
