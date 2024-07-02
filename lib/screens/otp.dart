import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_tut/screens/profile.dart';
import 'package:firebase_tut/uiWidgets.dart';
import 'package:firebase_tut/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:sms_autofill/sms_autofill.dart';

class OtpPage extends StatefulWidget {
  String verificationid;
  final String phone;

  OtpPage({
    required this.verificationid,
    required this.phone,
    Key? key,
  }) : super(key: key);

  @override
  State<OtpPage> createState() => _OtpPageState();
}

class _OtpPageState extends State<OtpPage> with CodeAutoFill {
  TextEditingController otpController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _listenOtp();
  }

  @override
  void codeUpdated() {
    setState(() {
      otpController.text = code ?? '';
    });
  }

  void _listenOtp() async {
    await SmsAutoFill().listenForCode;
  }

  @override
  void dispose() {
    SmsAutoFill().unregisterListener();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            onPressed: () => Get.back(),
            icon: Icon(
              Icons.arrow_back,
              size: 24.sp,
            ),
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: 48.h),
              Center(child: UiHelper.customizeText('Verify Code')),
              SizedBox(height: 8.h),
              Center(
                child: UiHelper.customizeTextSmall(
                  'Code sent to ${widget.phone}',
                ),
              ),
              SizedBox(height: 24.h),
              Padding(
                padding: EdgeInsets.all(8.0),
                child: PinFieldAutoFill(
                  controller: otpController,
                  decoration: BoxLooseDecoration(
                    strokeColorBuilder: PinListenColorBuilder(
                      Color.fromRGBO(147, 210, 243, 1),
                      Color.fromRGBO(147, 210, 243, 1),
                    ),
                    obscureStyle: ObscureStyle(isTextObscure: false),
                    gapSpace: 10.0,
                    radius: Radius.circular(0.0),
                    textStyle: TextStyle(
                      color: Colors.black,
                      fontSize: 20.sp,
                      fontWeight: FontWeight.bold,
                    ),
                    bgColorBuilder: FixedColorBuilder(
                      Color.fromRGBO(147, 210, 243, 1),
                    ),
                    strokeWidth: 2,
                  ),
                  autoFocus: true,
                  cursor: Cursor(
                    color: const Color.fromARGB(255, 19, 19, 19),
                    enabled: true,
                    width: 1,
                  ),
                  currentCode: '',
                  onCodeSubmitted: (code) async {
                    try {
                      PhoneAuthCredential credential =
                          PhoneAuthProvider.credential(
                        verificationId: widget.verificationid,
                        smsCode: code,
                      );

                      final authResult = await FirebaseAuth.instance
                          .signInWithCredential(credential);
                      if (authResult.user != null) {
                        // Navigate to profile page on successful verification
                        Get.to(ProfilePage());
                      } else {
                        Utils().toastMessage('User authentication failed.');
                      }
                    } catch (ex) {
                      log('Error signing in: $ex');
                      Utils().toastMessage('Something went wrong.');
                    }
                  },
                  codeLength: 6,
                  onCodeChanged: (code) {
                    // Handle code change
                    print(code);
                  },
                ),
              ),
              SizedBox(height: 16.h),
              UiHelper.customizeRichText(
                onPressed: () async {
                  Utils().toastMessage(
                      'Otp send to your ${widget.phone}.Please enter otp again.');
                  try {
                    await FirebaseAuth.instance.verifyPhoneNumber(
                      phoneNumber: widget.phone,
                      verificationCompleted:
                          (PhoneAuthCredential credential) {},
                      verificationFailed: (FirebaseAuthException ex) {
                        Utils().toastMessage('Error: ${ex.message}');
                      },
                      codeSent: (String verificationId, int? resendToken) {
                        setState(() {
                          // Update verification ID if needed
                          // In most cases, this won't need to be updated again
                          // as it's set initially in the constructor
                          widget.verificationid = verificationId;
                        });
                      },
                      codeAutoRetrievalTimeout: (String verificationId) {},
                      forceResendingToken: null,
                    );
                  } catch (e) {
                    log('Error verifying phone number: $e');
                    Utils().toastMessage('Failed to resend OTP.');
                  }
                },
              ),
              SizedBox(height: 24.h),
              UiHelper.customizeTextCB(
                text: 'VERIFY AND CONTINUE',
                width: 328.w,
                height: 56.h,
                onPressed: () async {
                  try {
                    PhoneAuthCredential credential =
                        PhoneAuthProvider.credential(
                      verificationId: widget.verificationid,
                      smsCode: otpController.text.trim(),
                    );

                    final authResult = await FirebaseAuth.instance
                        .signInWithCredential(credential);
                    if (authResult.user != null) {
                      Get.to(
                          ProfilePage()); // Navigate to profile page on successful verification
                    } else {
                      Utils().toastMessage('User authentication failed.');
                    }
                  } catch (ex) {
                    log('Error signing in: $ex');
                    Utils().toastMessage('Something went wrong.');
                  }
                },
              ),
              SizedBox(height: 161.h),
              Image.asset(
                'assets/images/p4.png',
                width: screenWidth,
                height: 144.h,
                fit: BoxFit.fill,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
