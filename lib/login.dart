import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';

import 'home.dart';
import 'constants.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ConstantColours.backgroundBlue,
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
                            Constants.byUnitic,
                            textAlign: TextAlign.right,
                            style: GoogleFonts.mukta(
                              fontSize: 18,
                              color: const Color(0xFFFFFFFF),
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
                  color: const Color(0xFFFFFFFF),
                  // shadows: <Shadow> [
                  //   const Shadow(
                  //     offset: Offset(0.5, 0.5),
                  //     blurRadius: 1.0,
                  //     color: Color.fromARGB(255, 0, 0, 0),
                  //   ),
                  //   const Shadow(
                  //     offset: Offset(0.5, 0.5),
                  //     blurRadius: 4.0,
                  //     color: Color.fromARGB(125, 0, 0, 255),
                  //   ),
                  // ],
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.all(20),
            ),
            Column(
              // TODO: change these guys to pushReplacement
              // Needed so that there's no back button after login
              // Fine for now because testing and stuff
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SignInButton(
                      Buttons.Google,
                      onPressed: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) =>
                                const HomePage(title: Constants.homePage)));
                      },
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SignInButton(
                      Buttons.Facebook,
                      onPressed: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) =>
                                const HomePage(title: Constants.homePage)));
                      },
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SignInButton(
                      Buttons.Email,
                      onPressed: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) =>
                                const HomePage(title: Constants.homePage)));
                      },
                    ),
                  ],
                ),
                TextButton(
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) =>
                            const HomePage(title: Constants.homePage)));
                  },
                  child: Text(
                    Constants.troubleSigning,
                    textAlign: TextAlign.center,
                    style: GoogleFonts.mukta(
                      fontSize: 14,
                      color: const Color(0xFFFFFFFF),
                      shadows: <Shadow>[
                        const Shadow(
                          offset: Offset(0.5, 0.5),
                          blurRadius: 1.0,
                          color: Color.fromARGB(255, 0, 0, 0),
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
