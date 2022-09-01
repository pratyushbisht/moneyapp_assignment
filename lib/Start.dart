import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
import 'package:moneyy_app_assignment/Login.dart';
import 'package:moneyy_app_assignment/main.dart';
import 'package:moneyy_app_assignment/utils/text.dart';
import 'SignUp.dart';
import 'package:google_sign_in/google_sign_in.dart';

class Start extends StatefulWidget {
  @override
  _StartState createState() => _StartState();
}

class _StartState extends State<Start> {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<UserCredential> googleSignIn() async {
    GoogleSignIn googleSignIn = GoogleSignIn();
    GoogleSignInAccount? googleUser = await googleSignIn.signIn();
    if (googleUser != null) {
      GoogleSignInAuthentication googleAuth = await googleUser.authentication;

      if (googleAuth.idToken != null && googleAuth.accessToken != null) {
        final AuthCredential credential = GoogleAuthProvider.credential(
            accessToken: googleAuth.accessToken, idToken: googleAuth.idToken);

        final UserCredential user =
        await _auth.signInWithCredential(credential);

        await Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (context) => Home()));

        return user;
      } else {
        throw StateError('Missing Google Auth Token');
      }
    } else
      throw StateError('Sign in Aborted');
  }

  navigateToLogin() async {
    Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (context) => Login()));
  }

  navigateToRegister() async {
    Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (context) => SignUp()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Column(
          children: <Widget>[
            SizedBox(height:100.0),
            // Row(
            //   mainAxisAlignment: MainAxisAlignment.center,
            //   children: <Widget>[
            //     RaisedButton(
            //         padding: EdgeInsets.only(left: 30, right: 30),
            //         onPressed: navigateToLogin,
            //         child: Text(
            //           'LOGIN',
            //           style: TextStyle(
            //             fontSize: 20,
            //             fontWeight: FontWeight.bold,
            //             color: Colors.white,
            //           ),
            //         ),
            //         shape: RoundedRectangleBorder(
            //           borderRadius: BorderRadius.circular(10.0),
            //         ),
            //         color: Colors.blue),
            //     SizedBox(width: 20.0),
            //     RaisedButton(
            //         padding: EdgeInsets.only(left: 30, right: 30),
            //         onPressed: navigateToRegister,
            //         child: Text(
            //           'REGISTER',
            //           style: TextStyle(
            //             fontSize: 20,
            //             fontWeight: FontWeight.bold,
            //             color: Colors.white,
            //           ),
            //         ),
            //         shape: RoundedRectangleBorder(
            //           borderRadius: BorderRadius.circular(10.0),
            //         ),
            //         color: Colors.blue),
            //   ],
            // ),
            SizedBox(height: 20.0),
            modified_text(text: 'Welcome to Money App', color: Colors.white, size: 30),
            SizedBox(height: 20.0),
            Center(
              child: SignInButton(Buttons.Google,
                  text: "Sign up with Google", onPressed: googleSignIn),
            )
          ],
        ),
      ),
    );
  }
}