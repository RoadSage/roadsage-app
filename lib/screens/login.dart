import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;

import 'package:roadsage/constants.dart';
import 'package:roadsage/authentication/auth_services.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  firebase_auth.FirebaseAuth firebaseAuth = firebase_auth.FirebaseAuth.instance;
  AuthClass authClass = AuthClass();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: RoadSageColours.lightBlue,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Padding(
              padding: EdgeInsets.all(120),
            ),
            SizedBox(
              width: 220,
              child: Stack(
                children: [
                  Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                    Text(
                      Constants.title,
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.headline3,
                    ),
                  ]),
                  Container(
                    padding: const EdgeInsets.only(top: 60),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(
                            Constants.byUnitic,
                            textAlign: TextAlign.right,
                            style: Theme.of(context).textTheme.subtitle1,
                          ),
                        ]),
                  ),
                ],
              ),
            ),
            const Padding(
              padding: EdgeInsets.all(50),
            ),
            SizedBox(
              width: 325,
              child: Text(
                Constants.tncAgreement,
                textAlign: TextAlign.center,
                style: GoogleFonts.mukta(
                  fontSize: 14,
                  color: Colors.white,
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.all(20),
            ),
            Column(
              // TODO: change these guys to pushReplacementNamed
              // Needed so that there's no back button after login
              // Fine for now because testing and stuff
              children: [
                SignInButtonBuilder(
                    text: RoadSageStrings.signInWithGoogle,
                    textColor: Colors.black54,
                    image: Image.asset(
                      RoadSageIcons.googleIcon,
                      height: 20,
                    ),
                    backgroundColor: Colors.white,
                    // innerPadding: EdgeInsets.only(left: 10),
                    onPressed: () => authClass.signInWithGoogle(context),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15))),
                SignInButton(
                  Buttons.Facebook,
                  onPressed: () => authClass.signInWithFacebook(context),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15)),
                ),
                SignInButton(
                  Buttons.Email,
                  text: "Login / Sign up",
                  onPressed: () => Navigator.pushNamed(context, Routes.home),
                  // onPressed: () => authClass.signUp(context, email: 'test', password: 'test'),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15)),
                ),
                TextButton(
                  onPressed: () => Navigator.pushNamed(context, Routes.home),
                  child: Text(
                    Constants.troubleSigning,
                    textAlign: TextAlign.center,
                    style: GoogleFonts.mukta(
                      fontSize: 14,
                      color: Colors.white,
                      shadows: <Shadow>[
                        const Shadow(
                          offset: Offset(0.5, 0.5),
                          blurRadius: 1.0,
                          color: Colors.black,
                        ),
                        const Shadow(
                          offset: Offset(0.5, 0.5),
                          blurRadius: 4.0,
                          color: Color.fromARGB(125, 0, 0, 255),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
