import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:roadsage/constants.dart';

import 'package:flutter_translate/flutter_translate.dart';

/// Screen showing help & feedback
class HelpScreen extends StatefulWidget {
  const HelpScreen({Key? key}) : super(key: key);

  @override
  State<HelpScreen> createState() => _HelpScreenState();
}

class _HelpScreenState extends State<HelpScreen> {
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Container(
        child: Padding(
            padding: const EdgeInsets.only(top: 28.0),
            child: ListView(children: <Widget>[
              Padding(
                  child: Text(
                    translate(RoadSageStrings.helpAndFeedbackDesc),
                    textAlign: TextAlign.center,
                  ),
                  padding: const EdgeInsets.all(20.0)),

              Padding(
                  child: Container(
                    color: Theme.of(context).primaryColorLight,
                    child: TextFormField(
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your name';
                        }
                        return null;
                      },
                      maxLines: 1,
                      decoration: InputDecoration(
                        hintText: translate(RoadSageStrings.formName),
                        filled: true,
                      ),
                    ),
                  ),
                  padding: const EdgeInsets.fromLTRB(20, 1.0, 20, 10.0)),
              Padding(
                  child: Container(
                    color: Theme.of(context).primaryColorLight,
                    child: TextFormField(
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your email';
                        } else if (!RegExp(
                                r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                            .hasMatch(value)) {
                          return 'Please enter a valid email';
                        }
                        return null;
                      },
                      maxLines: 1,
                      decoration: InputDecoration(
                        hintText: translate(RoadSageStrings.formEmail),
                        filled: true,
                      ),
                    ),
                  ),
                  padding: const EdgeInsets.fromLTRB(20, 1.0, 20, 10.0)),

              Padding(
                  child: Text(
                    translate(RoadSageStrings.giveFeedback),
                    textAlign: TextAlign.center,
                    style: const TextStyle(fontSize: 16),
                  ),
                  padding: const EdgeInsets.fromLTRB(20, 1.0, 20, 10.0)),

              Padding(
                  child: Container(
                    color: Theme.of(context).primaryColorLight,
                    child: TextFormField(
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter feedback.';
                        }
                        return null;
                      },
                      maxLines: 13,
                      decoration: InputDecoration(
                          filled: true,
                          hintText: translate(RoadSageStrings.feedbackHint)),
                    ),
                  ),
                  padding: const EdgeInsets.fromLTRB(20, 1.0, 20, 10.0)),

              Padding(
                  padding: const EdgeInsets.fromLTRB(20, 20, 20, 30),
                  child: SizedBox(
                      width: double.infinity,
                      height: 50,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            textStyle: const TextStyle(fontSize: 20)),
                        onPressed: () => submit(_formKey),
                        child: Text(translate(RoadSageStrings.formSubmit)),
                      ))),

              /// Contact us
              getButtonContainer(translate(RoadSageStrings.contactUs), ""),
              getButtonContainer(translate(RoadSageStrings.faqs), Routes.faq),
              getButtonContainer(translate(RoadSageStrings.rateUs), "")
            ])),
        padding: const EdgeInsets.all(0.0),
        alignment: Alignment.center,
      ),
    );
  }

  /// Helper function to create button containers
  Widget getButtonContainer(final String text, String route) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 18.0),
      child: ElevatedButton.icon(
          onPressed: () => Navigator.pushNamed(context, route),
          icon:
              const Icon(Icons.info_outline, color: RoadSageColours.lightBlue),
          style: ButtonStyle(
            padding: MaterialStateProperty.all(
                const EdgeInsets.symmetric(vertical: 8)),
            backgroundColor:
                MaterialStateProperty.all(Theme.of(context).primaryColorLight),
          ),
          label: Text(
            text,
            style: Theme.of(context).textTheme.button,
          )),
    );
  }

  /// Function called when the fedeback 'submit' button is pressed
  static void submit(GlobalKey<FormState> formKey) {
    // formKey.currentState!.save();
    if (formKey.currentState!.validate()) {
      // TODO: When the API supports it, this is where feedback should be sent
      Fluttertoast.showToast(msg: "Feedback submitted!");
    }
  }
}
