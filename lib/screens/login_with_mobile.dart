import 'dart:io';

import 'package:flutter/material.dart';
import 'package:roadsage/constants.dart';
import 'package:roadsage/widgets/custom_button.dart';

class LoginWithMobileScreen extends StatelessWidget {
  const LoginWithMobileScreen({Key? key}) : super(key: key);

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
                "PHONE",
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
                _buildTextField(label: "Phone Number"),
                const SizedBox(
                  height: 10,
                ),
                CustomButton(
                  onPressed: () {
                    var route =
                        Platform.isIOS ? Routes.permission : Routes.home;
                    Navigator.pushNamedAndRemoveUntil(
                        context, route, (r) => false);
                  },
                  title: "SEND CODE",
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
