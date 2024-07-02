import 'package:firebase_tut/screens/phone.dart';
import 'package:firebase_tut/uiWidgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  int selectedContainerIndex = -1; // -1 means no container selected initially

  void selectContainer(int index) {
    setState(() {
      if (selectedContainerIndex == index) {
        selectedContainerIndex = -1; // Deselect if already selected
      } else {
        selectedContainerIndex = index; // Select the tapped container
      }
    });
  }

  bool isFilled = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: 88.h,
              ),
              Center(
                  child: UiHelper.customizeText(
                "Please select your profile",
              )),
              SizedBox(
                height: 26.h,
              ),
              customizeProfileContainer(
                onPressed: () => selectContainer(0),
                isSelected: selectedContainerIndex == 0,
                image: Image.asset('assets/images/home.png'),
                text: 'Shipper',
                text1: 'Lorem ipsum dolor sit amet,\nconsectetur adipiscing',
              ),
              SizedBox(height: 24),
              customizeProfileContainer(
                onPressed: () => selectContainer(1),
                isSelected: selectedContainerIndex == 1,
                image: Image.asset('assets/images/truck.png'),
                text: 'Transporter',
                text1: 'Lorem ipsum dolor sit amet,\nconsectetur adipiscing',
              ),
              SizedBox(
                height: 24.h,
              ),
              UiHelper.customizeTextCB(
                  onPressed: () {},
                  text: 'CONTINUE',
                  width: 328.w,
                  height: 56.h),
            ]),
      ),
    );
  }

  Widget customizeProfileContainer({
    required VoidCallback onPressed,
    required bool isSelected,
    required Image image,
    required String text,
    required String text1,
  }) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        alignment: Alignment.center,
        width: 328,
        height: 89,
        child: Row(
          children: [
            SizedBox(width: 16),
            Container(
                width: 24.w,
                height: 24.h,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    width: 1.w,
                    color: Color.fromRGBO(0, 0, 0, 1),
                  ),
                  // Show filled circle if selected
                  //   color: isSelected
                  //       ? Colors.transparent
                  //       : Color.fromRGBO(46, 59, 98, 1),
                ),
                child: isSelected
                    ? Icon(
                        Icons.circle,
                        size: 16.sp,
                        color: Color.fromRGBO(46, 59, 98, 1),
                      )
                    : Icon(
                        Icons.circle,
                        size: 16.sp,
                        color: Colors.white,
                      )),
            SizedBox(width: 8),
            image,
            SizedBox(width: 16),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  text,
                  style: TextStyle(
                    color: Color.fromRGBO(47, 48, 55, 1),
                    fontFamily: 'Roboto',
                    fontWeight: FontWeight.w400,
                    fontSize: 18,
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  text1,
                  softWrap: true,
                  style: TextStyle(
                    color: Color.fromRGBO(106, 108, 123, 1),
                    fontFamily: 'Roboto',
                    fontWeight: FontWeight.w400,
                    fontSize: 12,
                  ),
                )
              ],
            ),
          ],
        ),
        decoration: BoxDecoration(
          border: Border.all(
            width: 1,
            color: Color.fromRGBO(47, 48, 55, 1),
          ),
        ),
      ),
    );
  }
}
