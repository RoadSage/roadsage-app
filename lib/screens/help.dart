import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:roadsage/constants.dart';

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
              const Padding(
                  child: Text(
                    RoadSageStrings.helpAndFeedbackDesc,
                    textAlign: TextAlign.center,
                  ),
                  padding: EdgeInsets.all(20.0)),

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
                      decoration: const InputDecoration(
                        hintText: RoadSageStrings.formName,
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
                      decoration: const InputDecoration(
                        hintText: RoadSageStrings.formEmail,
                        filled: true,
                      ),
                    ),
                  ),
                  padding: const EdgeInsets.fromLTRB(20, 1.0, 20, 10.0)),

              const Padding(
                  child: Text(
                    RoadSageStrings.giveFeedback,
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 16),
                  ),
                  padding: EdgeInsets.fromLTRB(20, 1.0, 20, 10.0)),

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
                      decoration: const InputDecoration(
                          filled: true, hintText: RoadSageStrings.feedbackHint),
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
                        child: const Text(RoadSageStrings.formSubmit),
                      ))),

              // Contact us
              getButtonContainer(RoadSageStrings.contactUs, ""),
              getButtonContainer(RoadSageStrings.faqs, Routes.faq),
              getButtonContainer(RoadSageStrings.rateUs, "")
            ])),
        padding: const EdgeInsets.all(0.0),
        alignment: Alignment.center,
      ),
    );
  }

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
              backgroundColor: MaterialStateProperty.all(
                  Theme.of(context).primaryColorLight)),
          label: Text(
            text,
            style: Theme.of(context).textTheme.button,
          )),
    );
  }

  static void submit(GlobalKey<FormState> formKey) {
    formKey.currentState!.save();
    if (formKey.currentState!.validate()) {
      Fluttertoast.showToast(msg: "Feedback submitted!");
    }
  }
}
