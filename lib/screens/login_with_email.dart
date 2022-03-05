import 'package:flutter/material.dart';
import 'package:roadsage/constants.dart';
import 'package:roadsage/widgets/custom_button.dart';

class LoginWithEmailScreen extends StatelessWidget {
  const LoginWithEmailScreen({Key? key}) : super(key: key);

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
                "Email",
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
              children: [
                _buildTextField(label: "Email Address"),
                const SizedBox(
                  height: 10,
                ),
                const Text(
                  "By Continuing you agree to our Terms of Service and confirm that you read our privacy policy",
                  textAlign: TextAlign.center,
                ),
                const SizedBox(
                  height: 10,
                ),
                CustomButton(
                  onPressed: () {
                    Navigator.pushNamed(
                        context, Routes.verifyEmailScreenForLogin);
                  },
                  title: "LOGIN",
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
          style: const TextStyle(
            color: RoadSageColours.darkGrey,
          ),
          textScaleFactor: 1.1,
        ),
        TextFormField(),
      ],
    );
  }
}
