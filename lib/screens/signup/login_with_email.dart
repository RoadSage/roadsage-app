import 'package:flutter/material.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:roadsage/constants.dart';
import 'package:roadsage/screens/signup/email_otp_verify_for_login.dart';
import 'package:roadsage/screens/signup/register_with_email.dart';
import 'package:roadsage/widgets/custom_button.dart';

class LoginWithEmailScreen extends StatelessWidget {
  const LoginWithEmailScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(translate(RoadSageStrings.login)),
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
                translate(RoadSageStrings.email),
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
                  label: translate(RoadSageStrings.emailAddress),
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
                        builder: (context) => const EmailVerifyScreenLogin(),
                      ),
                    );
                  },
                  title: translate(RoadSageStrings.login).toUpperCase(),
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => const RegisterWithEmailScreen(),
                      ),
                    );
                  },
                  child: Text(translate(RoadSageStrings.signUp)),
                  style: ElevatedButton.styleFrom(
                      textStyle: const TextStyle(fontSize: 17)),
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
          keyboardType: TextInputType.emailAddress,
        ),
      ],
    );
  }
}
