import 'package:flutter/material.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:roadsage/authentication/auth_services.dart';
import 'package:roadsage/constants.dart';
import 'package:roadsage/screens/signup/email_otp_verify_screen.dart';
import 'package:roadsage/widgets/custom_button.dart';

class RegisterWithEmailScreen extends StatefulWidget {
  const RegisterWithEmailScreen({Key? key}) : super(key: key);

  @override
  State<RegisterWithEmailScreen> createState() =>
      _RegisterWithEmailScreenState();
}

class _RegisterWithEmailScreenState extends State<RegisterWithEmailScreen> {
  final _formKey = GlobalKey<FormState>();
  final AuthClass authClass = AuthClass();

  String? firstName;
  String? lastName;
  String? email;
  String? password;

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
      body: Form(
        key: _formKey,
        child: ListView(
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
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        translate(RoadSageStrings.firstName),
                        textScaleFactor: 1.1,
                      ),
                      TextFormField(
                        validator: (String? value) {
                          if (value == null || value.trim().isEmpty) {
                            return 'First name is required';
                          }
                          return null;
                        },
                        onSaved: (String? value) {
                          firstName = value;
                        },
                      ),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        translate(RoadSageStrings.lastName),
                        textScaleFactor: 1.1,
                      ),
                      TextFormField(
                        validator: (String? value) {
                          if (value == null || value.trim().isEmpty) {
                            return 'Last name is required';
                          }
                          return null;
                        },
                        onSaved: (String? value) {
                          lastName = value;
                        },
                      ),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        translate(RoadSageStrings.email),
                        textScaleFactor: 1.1,
                      ),
                      TextFormField(
                        keyboardType: TextInputType.emailAddress,
                        validator: (String? value) {
                          if (value == null || value.trim().isEmpty) {
                            return 'Email is required';
                          }
                          return null;
                        },
                        onSaved: (String? value) {
                          email = value;
                        },
                      ),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        translate(RoadSageStrings.password),
                        textScaleFactor: 1.1,
                      ),
                      TextFormField(
                        obscureText: true,
                        keyboardType: TextInputType.visiblePassword,
                        validator: (String? value) {
                          if (value == null || value.trim().isEmpty) {
                            return 'Password is required';
                          }
                          return null;
                        },
                        onSaved: (String? value) {
                          password = value;
                        },
                      ),
                    ],
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
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        _formKey.currentState!.save();

                        if (await authClass.signUpAPI(
                            email: email,
                            fullName: "$firstName $lastName",
                            password: password)) {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => const EmailVerifyScreen(),
                            ),
                          );
                        } else {
                          Fluttertoast.showToast(msg: "An error has ocurred");
                        }
                      }
                    },
                    title: translate(RoadSageStrings.signUp),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
