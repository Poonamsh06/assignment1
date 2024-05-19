import 'dart:developer';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:firebase_tut/uiWidgets.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  File? pickedImage;
  signUp(
    String email,
    String password,
  ) async {
    if (email == "" && password == " " && pickedImage == "") {
      return UiHelper.CustomizeAlertBox(context, "Enter required fields.");
    } else {
      UserCredential? userCredential;
      try {
        userCredential = await FirebaseAuth.instance
            .createUserWithEmailAndPassword(email: email, password: password);

        await uploadData();
      } catch (ex) {
        log(ex.toString());
      }
    }
  }

  uploadData() async {
    Reference ref = FirebaseStorage.instance
        .ref("Profile Pics")
        .child(emailController.text.toString());

    UploadTask uploadTask = ref.putFile(pickedImage!);

    TaskSnapshot taskSnapshot = await uploadTask;
    String url = await taskSnapshot.ref.getDownloadURL();

    FirebaseFirestore.instance
        .collection("users")
        .doc(emailController.text.toString())
        .set({"Email": emailController.text.toString(), "Image": url}).then(
            (onValue) {
      log("User uploaded");
    });
  }

  showAlertBox() {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Pick Image from"),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                ListTile(
                  onTap: () {
                    pickImage(ImageSource.camera);
                    Navigator.pop(context);
                  },
                  leading: Icon(Icons.camera_alt),
                  title: Text("Camera"),
                ),
                ListTile(
                  onTap: () {
                    pickImage(ImageSource.gallery);
                    Navigator.pop(context);
                  },
                  leading: Icon(Icons.image),
                  title: Text("Gallery"),
                ),
              ],
            ),
          );
        });
  }

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Sign up",
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          // mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.16,
              width: MediaQuery.of(context).size.width * 0.35,
              child: InkWell(
                onTap: () {
                  showAlertBox();
                },
                child: pickedImage != null
                    ? CircleAvatar(
                        backgroundColor: Color.fromARGB(
                          255,
                          69,
                          29,
                          138,
                        ),
                        radius: 100,
                        backgroundImage: FileImage(pickedImage!),
                      )
                    : const CircleAvatar(
                        backgroundColor: Color.fromARGB(
                          255,
                          69,
                          29,
                          138,
                        ),
                        radius: 100,
                        child: Icon(
                          Icons.person,
                          size: 75,
                          color: Colors.white,
                        ),
                      ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            UiHelper.CustomizeTextField(
                emailController, "Email", false, Icon(Icons.email)),
            const SizedBox(
              height: 20,
            ),
            UiHelper.CustomizeTextField(
                passwordController, "Password", false, Icon(Icons.password)),
            const SizedBox(
              height: 30,
            ),
            UiHelper.CustomizedButton(() {
              signUp(emailController.text.toString(),
                  passwordController.text.toString());
            }, "Submit")
          ],
        ),
      ),
    );
  }

  pickImage(ImageSource imageSource) async {
    try {
      final photo = await ImagePicker().pickImage(source: imageSource);
      if (photo == null) return;
      final tempImage = File(photo.path);
      setState(() {
        pickedImage = tempImage;
      });
    } catch (ex) {
      log(ex.toString());
    }
  }
}
