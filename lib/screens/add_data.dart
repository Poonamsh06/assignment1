import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_tut/uiWidgets.dart';
import 'package:flutter/material.dart';

class AddData extends StatefulWidget {
  const AddData({super.key});

  @override
  State<AddData> createState() => _AddDataState();
}

class _AddDataState extends State<AddData> {
  TextEditingController titleController = TextEditingController();
  TextEditingController desController = TextEditingController();
  addData(String title, String description) async {
    if (title == "" && description == "") {
      return UiHelper.CustomizeAlertBox(context, "Enter required fields");
    } else {
      await FirebaseFirestore.instance
          .collection("user_data")
          .doc(title)
          .set({"title": title, "description": description}).then((onValue) {
        log("User Data Inserted.");
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add Data"),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextFormField(
              controller: titleController,
              decoration: InputDecoration(
                  hintText: "Enter your Title",
                  labelText: "Title",
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10))),
            ),
            SizedBox(
              height: 20,
            ),
            TextFormField(
              controller: desController,
              decoration: InputDecoration(
                  hintMaxLines: 5,
                  hintText: "Enter Description",
                  labelText: "Description",
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10))),
            ),
            SizedBox(
              height: 40,
            ),
            UiHelper.CustomizedButton(
                () => addData(titleController.text.toString(),
                    desController.text.toString()),
                "Add Data")
          ],
        ),
      ),
    );
  }
}
