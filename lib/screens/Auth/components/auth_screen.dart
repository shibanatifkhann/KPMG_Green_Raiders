import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutterfire_ui/auth.dart';
import 'package:green_raiders/constants.dart';
import 'package:green_raiders/screens/Home/componennts/home_screen.dart';


class AuthPage extends StatelessWidget {



  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            ///user is signed in
            return HomeScreen();
          } else {
            ///user is not signed in
            return SignInScreen(
              providerConfigs: [
                EmailProviderConfiguration(),
              ],

              subtitleBuilder: (context, action) =>
                  Padding(
                    padding: EdgeInsets.only(bottom: 12),
                    child: Text(

                        action == AuthAction.signIn
                            ? "Welcome back! Please use your credentials to sign in."
                            : "Please provide us with your email and create a strong password."
                    ),
                  ),
              footerBuilder: (context, _) =>
                  Padding(
                    padding: EdgeInsets.only(top: 16),
                    child: Text(
                        'By signing in, you agree to our terms and conditions',
                        style: TextStyle(color: kTextColor)),
                  ),
            );
          }
        }
    );
  }
}