import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_tut/screens/final.dart';
import 'package:firebase_tut/screens/forget_passward.dart';
import 'package:firebase_tut/screens/sign_up.dart';
import 'package:firebase_tut/services.dart';
import 'package:firebase_tut/uiWidgets.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

// class SignUpPage extends StatelessWidget {
//   final TextEditingController emailController = TextEditingController();
//   final TextEditingController passwordController = TextEditingController();

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Sign Up'),
//         centerTitle: true,
//       ),
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
//                   // Call the sign-up method from auth_service.dart
//                   bool signedUp = await AuthService().signUp(email, password);
//                   if (signedUp) {
//                     print("Successfully");
//                   } else {
//                     print("not logged in");
//                   }
//                 },
//                 child: Text('Sign Up'),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  loginFun(String email, String password) async {
    if (email == "" && password == "") {
      return UiHelper.CustomizeAlertBox(context, "Enter required fields");
    } else {
      UserCredential? userCredential;
      try {
        userCredential = await FirebaseAuth.instance
            .signInWithEmailAndPassword(email: email, password: password);
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
        title: Text("Login"),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 40),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            UiHelper.CustomizeTextField(
                emailController, "Email", false, const Icon(Icons.email)),
            const SizedBox(
              height: 20,
            ),
            UiHelper.CustomizeTextField(passwordController, "Password", true,
                const Icon(Icons.password)),
            const SizedBox(
              height: 30,
            ),
            UiHelper.CustomizedButton(() {
              loginFun(emailController.text.toString(),
                  passwordController.text.toString());
            }, "Login"),
            const SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text(
                  "Already have an account?",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.normal),
                ),
                InkWell(
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => SignUp()));
                  },
                  child: Text(
                    "Signup",
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.normal,
                        color: Colors.blue),
                  ),
                ),
              ],
            ),
            TextButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => ForgotPassward()));
              },
              child: Text(
                "Forgot Password??",
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.normal,
                    color: Colors.blue),
              ),
            )
          ],
        ),
      ),
    );
  }
}
