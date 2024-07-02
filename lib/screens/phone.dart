import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_tut/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:firebase_tut/screens/otp.dart';
import 'package:firebase_tut/uiWidgets.dart';
import 'package:sms_autofill/sms_autofill.dart';

class PhonePage extends StatefulWidget {
  const PhonePage({Key? key}) : super(key: key);

  @override
  _PhonePageState createState() => _PhonePageState();
}

class _PhonePageState extends State<PhonePage> {
  TextEditingController controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    _initSmsAutoFill();
  }

  void _initSmsAutoFill() async {
    await SmsAutoFill().getAppSignature;
  }

  @override
  Widget build(BuildContext context) {
    print(SmsAutoFill().getAppSignature);
    double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Get.back(),
          icon: Icon(
            Icons.close,
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
            UiHelper.customizeText("Please enter your mobile number"),
            SizedBox(height: 8.h),
            Center(
              child: UiHelper.customizeTextSmall(
                'You’ll receive a 6-digit code\nto verify next.',
              ),
            ),
            SizedBox(height: 32.h),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.h),
              child: Container(
                alignment: Alignment.center,
                width: 328.w,
                height: 56.h,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10.h),
                  child: Row(
                    children: [
                      Image.asset('assets/images/india 2.png'),
                      Padding(
                        padding: EdgeInsets.only(left: 10.h),
                        child: UiHelper.customizeTextCountry('+91'),
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 16.h),
                        child: UiHelper.customizeTextCountry('-'),
                      ),
                      SizedBox(
                        width: 16.w,
                      ),
                      Expanded(
                        child: TextField(
                          controller: controller,
                          decoration: InputDecoration(
                            hintText: 'Mobile number',
                            border: InputBorder.none,
                            isDense: true,
                            contentPadding: EdgeInsets.zero,
                          ),
                          keyboardType: TextInputType.phone,
                          style: TextStyle(
                            fontFamily: 'Roboto',
                            fontWeight: FontWeight.w400,
                            fontSize: 16.sp,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                decoration: BoxDecoration(
                  color: Colors.blue.withOpacity(0.0),
                  border: Border.all(
                    width: 1,
                    color: Color.fromRGBO(47, 48, 55, 1),
                  ),
                ),
              ),
            ),
            SizedBox(height: 24.h),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.h),
              child: UiHelper.customizeTextCB(
                text: 'CONTINUE',
                width: 328.w,
                height: 56.h,
                onPressed: () async {
                  if (controller.text.trim().isEmpty) {
                    Utils().toastMessage('Please enter a valid mobile number.');
                    return;
                  }
                  final phoneNumber = '+91${controller.text.trim()}';
                  await FirebaseAuth.instance.verifyPhoneNumber(
                    verificationCompleted: (PhoneAuthCredential credential) {},
                    verificationFailed: (FirebaseAuthException ex) {
                      Utils().toastMessage('Error: ${ex.message}');
                    },
                    codeSent: (String verificationId, int? resendToken) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => OtpPage(
                            verificationid: verificationId,
                            phone: phoneNumber,
                          ),
                        ),
                      );
                    },
                    codeAutoRetrievalTimeout: (String verificationId) {},
                    phoneNumber: phoneNumber,
                  );
                },
              ),
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
    );
  }
}
