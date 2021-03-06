import 'package:flutter/material.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:roadsage/constants.dart';

/// Screen for verification after signing up with a mobile phone number
class VerifyMobileScreen extends StatelessWidget {
  const VerifyMobileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(translate(RoadSageStrings.mobile)),
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
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
            child: Center(
              child: Text(
                translate(RoadSageStrings.enter6DigitCode),
                style: const TextStyle(
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
                Text(
                  translate(RoadSageStrings.checkYourMessages),
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
                    Navigator.of(context)
                        .pushNamedAndRemoveUntil(Routes.home, (route) => false);
                  },
                  onChanged: (String value) {},
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  translate(RoadSageStrings.resendCode),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
