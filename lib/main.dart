import 'package:flutter/material.dart';
import 'home.dart';
import 'login.dart';

// 0AC0FF

void main() {
  runApp(const RoadSageApp());
}

class RoadSageApp extends StatelessWidget {
  const RoadSageApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'RoadSage',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const LoginPage(title: 'RoadSage Home Page'),
    );
  }
}
