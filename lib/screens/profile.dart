import 'package:firebase_tut/screens/phone.dart';
import 'package:firebase_tut/uiWidgets.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
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
                height: MediaQuery.of(context).size.height * 0.1,
              ),
              Center(
                  child: UiHelper.customizeText(
                "Please select your profile",
              )),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.03,
              ),
              UiHelper.customizeProfileContainer(
                onPressed: () => setState(() {
                  isFilled = !isFilled; // Toggle the filled state on tap
                }),
                isFilled: isFilled,
                image: Image.asset('assets/images/home.png'),
                text: 'Shipper',
                text1: 'Lorem ipsum dolor sit amet,\nconsectetur adipiscing',
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.03,
              ),
              UiHelper.customizeProfileContainer(
                onPressed: () => setState(() {
                  isFilled = !isFilled; // Toggle the filled state on tap
                }),
                isFilled: isFilled,
                image: Image.asset('assets/images/truck.png'),
                text: 'TransPorter',
                text1: 'Lorem ipsum dolor sit amet,\nconsectetur adipiscing',
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.032,
              ),
              UiHelper.customizeTextCB(
                  onPressed: () {}, text: 'Continue', width: 328, height: 56),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.33,
              ),
            ]),
      ),
    );
  }
}
