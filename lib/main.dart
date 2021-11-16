import 'package:flutter/material.dart';
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
      ),
      home: const LoginPage(title: Constants.loginPageTitle),
    );
  }
}
