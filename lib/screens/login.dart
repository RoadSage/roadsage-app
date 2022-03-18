import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import 'package:roadsage/authentication/permissions.dart';

import 'package:roadsage/constants.dart';
import 'package:roadsage/authentication/auth_services.dart';
import 'package:roadsage/screens/signup/login_with_email.dart';
import 'package:roadsage/screens/signup/login_with_mobile.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';

import 'package:flutter_translate/flutter_translate.dart';

/// Screen with different ways of logging into the app
class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final AuthClass authClass = AuthClass();
  firebase_auth.FirebaseAuth firebaseAuth = firebase_auth.FirebaseAuth.instance;

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
                      translate(RoadSageStrings.title),
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
                            translate(RoadSageStrings.byUnitic),
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
                translate(RoadSageStrings.tncAgreement),
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
              children: [
                // Checking the ios or android to show apple signin button
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
                          navigateOrError(Routes.home,
                              RoadSageStrings.permissionsFailed, context);
                        },
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15)),
                      )
                    : const SizedBox(),

                /// Hiding the google signin button in the ios
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
                        onPressed: () => authClass.signInWithGoogle(context),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15)),
                      ),
                SignInButton(
                  Buttons.Facebook,
                  onPressed: () async {
                    Resource? loginStatus =
                        await authClass.signInWithFacebook(context);
                    if (loginStatus != null &&
                        loginStatus.status == Status.success) {
                      // Check permissions and navigate to home screen
                      navigateOrError(Routes.home,
                          RoadSageStrings.permissionsFailed, context);
                    }
                  },
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15)),
                ),
                SignInButton(
                  Buttons.Email,
                  text:
                      "${translate(RoadSageStrings.login)} / ${translate(RoadSageStrings.signUp)}",
                  onPressed: () async {
                    await showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          title:
                              Text(translate(RoadSageStrings.loginSignUpUsing)),
                          actions: [
                            TextButton(
                              onPressed: () {
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        const LoginWithMobileScreen(),
                                  ),
                                );
                              },
                              child: Text(translate(RoadSageStrings.mobile)),
                            ),
                            TextButton(
                              onPressed: () {
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        const LoginWithEmailScreen(),
                                  ),
                                );
                              },
                              child: Text(translate(RoadSageStrings.email)),
                            )
                          ],
                        );
                      },
                    );
                  },
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15)),
                ),
                TextButton(
                  onPressed: () {
                    // TODO: this is for testing to bypass API for login
                    // should be removed in final production version
                    navigateOrError(Routes.home,
                        RoadSageStrings.permissionsFailed, context);
                  },
                  child: Text(
                    translate(RoadSageStrings.troubleSigning),
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
