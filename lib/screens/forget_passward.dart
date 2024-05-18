import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_tut/uiWidgets.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class ForgotPassward extends StatelessWidget {
  const ForgotPassward({super.key});

  @override
  Widget build(BuildContext context) {
    forgotPassword(String email) async {
      if (email == "") {
        return UiHelper.CustomizeAlertBox(
            context, "Enter your email for reset password.");
      } else {
        FirebaseAuth.instance
            .sendPasswordResetEmail(
          email: email,
        )
            .then((_) {
          print('Password reset email sent.');
        }).catchError((error) {
          print('Error: $error');
        });
      }
    }

    TextEditingController controller = TextEditingController();
    return Scaffold(
      appBar: AppBar(
        title: Text("Forgot Password"),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 40),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(
              height: 30,
            ),
            UiHelper.CustomizeTextField(
                controller, "Email", false, Icon(Icons.email)),
            SizedBox(
              height: 30,
            ),
            UiHelper.CustomizedButton(() {
              forgotPassword(controller.text.toString());
            }, "Reset Password")
          ],
        ),
      ),
    );
  }
}
