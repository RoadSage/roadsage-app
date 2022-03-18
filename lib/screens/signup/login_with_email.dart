import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:roadsage/authentication/auth_services.dart';
import 'package:roadsage/constants.dart';
import 'package:roadsage/screens/signup/email_otp_verify_for_login.dart';
import 'package:roadsage/screens/signup/register_with_email.dart';
import 'package:roadsage/state/models.dart';
import 'package:roadsage/widgets/custom_button.dart';

/// Screen for logging in to the API using email & password
class LoginWithEmailScreen extends ConsumerStatefulWidget {
  const LoginWithEmailScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<LoginWithEmailScreen> createState() =>
      _LoginWithEmailScreenState();
}

class _LoginWithEmailScreenState extends ConsumerState<LoginWithEmailScreen> {
  final _formKey = GlobalKey<FormState>();
  final AuthClass authClass = AuthClass();

  String? email;
  String? password;

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
                      ]),
                  const SizedBox(
                    height: 15,
                  ),
                  Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
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
                      ]),
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

                        // Try to sign into the API
                        if (await authClass.signInAPI(email!, password!)) {
                          // If successful, switch login status to logged in
                          // TODO: this should be performed within EmailVerifyScreen
                          // if and when the website api supports verification
                          ref
                              .read(roadSageModelProvider.notifier)
                              .switchLoggedIn(true);

                          // Navigate to email verify screen for verification
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) =>
                                  const EmailVerifyScreenLogin(),
                            ),
                          );
                        } else {
                          Fluttertoast.showToast(msg: "An error has ocurred");
                        }
                      }
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
      ),
    );
  }
}
