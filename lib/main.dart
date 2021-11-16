import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'login.dart';
import 'constants.dart';

void main() {
  runApp(const RoadSageApp());
}

class RoadSageApp extends StatelessWidget {
  const RoadSageApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: Constants.title,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        textTheme: TextTheme(
            headline3: GoogleFonts.mukta(
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
            subtitle1: GoogleFonts.mukta(
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
                ])),
      ),
      home: const LoginPage(title: Constants.loginPageTitle),
    );
  }
}
