import 'package:flutter/material.dart';
import 'home.dart';

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
      home: const HomePage(title: 'RoadSage Home Page'),
    );
  }
}
