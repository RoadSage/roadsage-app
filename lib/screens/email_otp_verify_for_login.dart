import 'dart:io';

import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:roadsage/constants.dart';

class EmailVerifyScreenLogin extends StatelessWidget {
  const EmailVerifyScreenLogin({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Log In"),
        centerTitle: true,
        backgroundColor: RoadSageColours.lightGrey,
        actions: const [
          Padding(
            padding: EdgeInsets.all(8.0),
            child: Icon(
              Icons.question_answer,
              color: RoadSageColours.lightBlue,
            ),
          )
        ],
      ),
      body: ListView(
        shrinkWrap: true,
        children: [
          Container(
            padding: const EdgeInsets.only(top: 20, bottom: 20),
            decoration: const BoxDecoration(color: RoadSageColours.lightBlue),
            child: const Center(
              child: Text(
                "Enter 6-Digit Code",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
                textScaleFactor: 1.2,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(30.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 10,
                ),
                const Text(
                  "Check your email inbox",
                ),
                const SizedBox(
                  height: 10,
                ),
                PinCodeTextField(
                  length: 6,
                  appContext: context,
                  obscureText: false,
                  animationType: AnimationType.fade,
                  animationDuration: const Duration(milliseconds: 300),
                  onCompleted: (v) {
                    var route =
                        Platform.isIOS ? Routes.permission : Routes.home;
                    Navigator.pushNamedAndRemoveUntil(
                        context, route, (r) => false);
                  },
                  onChanged: (String value) {},
                ),
                const SizedBox(
                  height: 10,
                ),
                const Text(
                  "Resend code 55s",
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
