import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;

import 'package:roadsage/constants.dart';
import 'package:roadsage/authentication/auth_services.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

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
                      RoadSageStrings.title,
                      textAlign: TextAlign.center,
                      style: GoogleFonts.mukta(
                        fontSize: 48,
                        color: Colors.white,
                        shadows: <Shadow>[
                          const Shadow(
                            offset: Offset(1.0, 1.0),
                            blurRadius: 3.0,
                            color: Color.fromARGB(255, 0, 0, 0),
                          ),
                          const Shadow(
                            offset: Offset(1.0, 1.0),
                            blurRadius: 8.0,
                            color: Color.fromARGB(125, 0, 0, 255),
                          ),
                        ],
                      ),
                    ),
                  ]),
                  Container(
                    padding: const EdgeInsets.only(top: 60),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(
                            RoadSageStrings.byUnitic,
                            textAlign: TextAlign.right,
                            style: GoogleFonts.mukta(
                                fontSize: 18,
                                color: Colors.white,
                                shadows: <Shadow>[
                                  const Shadow(
                                    offset: Offset(1.0, 1.0),
                                    blurRadius: 3.0,
                                    color: Color.fromARGB(255, 0, 0, 0),
                                  ),
                                  const Shadow(
                                    offset: Offset(1.0, 1.0),
                                    blurRadius: 8.0,
                                    color: Color.fromARGB(125, 0, 0, 255),
                                  ),
                                ]),
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
                RoadSageStrings.tncAgreement,
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
                Platform.isIOS
                    ? SignInButton(
                        Buttons.Apple,
                        onPressed: () async {
                          await SignInWithApple.getAppleIDCredential(
                            scopes: [
                              AppleIDAuthorizationScopes.email,
                              AppleIDAuthorizationScopes.fullName,
                            ],
                          );
                              Navigator.pushReplacementNamed(context, Routes.permission);
                        },
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15)),
                      )
                    : const SizedBox(),
                Platform.isIOS
                    ? const SizedBox()
                    : SignInButtonBuilder(
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
                            borderRadius: BorderRadius.circular(15)),
                      ),
                SignInButton(
                  Buttons.Facebook,
                  onPressed: () => authClass.signInWithFacebook(context),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15)),
                ),
                SignInButton(
                  Buttons.Email,
                  text: "Login / Sign up",
                  onPressed: () =>
                      Navigator.pushReplacementNamed(context, Routes.permission),
                  // onPressed: () => authClass.signUp(context, email: 'test', password: 'test'),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15)),
                ),
                TextButton(
                  onPressed: () => Navigator.pushNamed(context, Routes.permission),
                  child: Text(
                    RoadSageStrings.troubleSigning,
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
