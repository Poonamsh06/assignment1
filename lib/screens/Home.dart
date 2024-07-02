import 'package:firebase_tut/main.dart';
import 'package:firebase_tut/screens/phone.dart';
import 'package:firebase_tut/uiWidgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
        body: SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.only(top: 104.h),
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Center(
                child: SizedBox(
                    height: 56.h,
                    width: 56.w,
                    child: Image.asset('assets/images/image@2x.png')),
              ),
              SizedBox(
                height: 32.h,
              ),
              Center(
                  child: UiHelper.customizeText('Please select your Language')),
              SizedBox(
                height: 8.h,
              ),
              Center(
                  child: UiHelper.customizeTextSmall(
                'You can change the language\nat any time.',
              )),
              SizedBox(
                height: 24.h,
              ),
              Container(
                alignment: Alignment.center,
                width: 216.w,
                height: 48.h,
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
                height: 24.h,
              ),
              UiHelper.customizeTextCB(
                  onPressed: () {
                    Get.to(PhonePage());
                  },
                  text: 'NEXT',
                  width: 216.w,
                  height: 48.h),
              SizedBox(
                height: 127.h,
              ),
              Container(
                width: 400.w,
                height: 102.66.h,
                child: Stack(
                  children: [
                    Image.asset(
                      width: 400.w,
                      height: 112.80.h,
                      'assets/images/p2.png',
                      fit: BoxFit.fill,
                    ),
                    Image.asset(
                      width: 400.w,
                      height: 102.h,
                      'assets/images/p1.png',
                      fit: BoxFit.fill,
                    ),
                  ],
                ),
              )
            ]),
      ),
    ));
  }
}
