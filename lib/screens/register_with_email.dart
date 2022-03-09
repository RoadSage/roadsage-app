import 'package:flutter/material.dart';
import 'package:roadsage/constants.dart';
import 'package:roadsage/screens/email_otp_verify_screen.dart';
import 'package:roadsage/widgets/custom_button.dart';

class RegisterWithEmailScreen extends StatelessWidget {
  const RegisterWithEmailScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(RoadSageStrings.signUp),
        centerTitle: true,
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
                RoadSageStrings.email,
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
                _buildTextField(label: RoadSageStrings.firstName),
                _buildTextField(label: RoadSageStrings.lastName),
                _buildTextField(label: RoadSageStrings.emailAddress),
                _buildTextField(label: RoadSageStrings.dateOfBirth),
                const SizedBox(
                  height: 10,
                ),
                const Text(
                  RoadSageStrings.byContinuing,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(
                  height: 10,
                ),
                CustomButton(
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => const EmailVerifyScreen(),
                      ),
                    );
                  },
                  title: RoadSageStrings.signUp,
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
