import 'package:flutter/material.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:roadsage/constants.dart';
import 'package:roadsage/screens/signup/verify_mobile.dart';
import 'package:roadsage/widgets/custom_button.dart';

/// Screen for signing up to the RoadSage API using a mobile phone number
class RegisterWithMobile extends StatelessWidget {
  const RegisterWithMobile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(translate(RoadSageStrings.signUp)),
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
                translate(RoadSageStrings.mobile).toUpperCase(),
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
              children: [
                _buildTextField(
                  label: translate(RoadSageStrings.phoneNumber),
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  translate(RoadSageStrings.byContinuing),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(
                  height: 10,
                ),
                CustomButton(
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => const VerifyMobileScreen(),
                      ),
                    );
                  },
                  title: translate(RoadSageStrings.sendCode),
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  _buildTextField({String label = ""}) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(
          height: 10,
        ),
        Text(
          label,
          textScaleFactor: 1.1,
        ),
        TextFormField(
          keyboardType: TextInputType.phone,
        ),
      ],
    );
  }
}
