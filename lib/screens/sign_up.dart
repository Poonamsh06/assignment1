import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_tut/uiWidgets.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

import '../services.dart';
import 'final.dart';

// class LoginPage extends StatelessWidget {
//   final TextEditingController emailController = TextEditingController();
//   final TextEditingController passwordController = TextEditingController();

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text('Login')),
//       body: Center(
//         child: Padding(
//           padding: const EdgeInsets.symmetric(horizontal: 30),
//           child: Column(
//             children: <Widget>[
//               SizedBox(
//                 height: 30,
//               ),
//               TextField(
//                   controller: emailController,
//                   decoration: InputDecoration(labelText: 'Email')),
//               SizedBox(
//                 height: 20,
//               ),
//               TextField(
//                   controller: passwordController,
//                   decoration: InputDecoration(labelText: 'Password')),
//               SizedBox(
//                 height: 50,
//               ),
//               ElevatedButton(
//                 onPressed: () async {
//                   String email = emailController.text;
//                   String password = passwordController.text;
//                   // Call the login method from auth_service.dart
//                   bool loggedIn = await AuthService().login(email, password);
//                   if (loggedIn) {
//                     print("Successfully");
//                   } else {
//                     print("not logged in ");
//                   }
//                 },
//                 child: Text('Login'),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  signUp(String email, String password) async {
    if (email == "" && password == "") {
      UiHelper.CustomizeAlertBox(context, "Please Enter required fields");
    } else {
      UserCredential? userCredential;
      try {
        await FirebaseAuth.instance
            .createUserWithEmailAndPassword(email: email, password: password);
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => FinalPage()),
        );
        // .then((value) => Navigator.push(
        //     context, MaterialPageRoute(builder: (context) => FinalPage())));
      } on FirebaseAuthException catch (e) {
        return UiHelper.CustomizeAlertBox(context, e.code.toString());
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Sign up"),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 40),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            UiHelper.CustomizeTextField(
                emailController, "Email", false, Icon(Icons.email)),
            SizedBox(
              height: 20,
            ),
            UiHelper.CustomizeTextField(
                passwordController, "Password", true, Icon(Icons.password)),
            SizedBox(
              height: 30,
            ),
            UiHelper.CustomizedButton(() {
              signUp(emailController.text, passwordController.text);
            }, "Submit")
          ],
        ),
      ),
    );
  }
}
