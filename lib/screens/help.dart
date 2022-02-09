import 'package:flutter/material.dart';
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
            child: ListView(
                // mainAxisAlignment: MainAxisAlignment.start,
                // mainAxisSize: MainAxisSize.max,
                // crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  const Padding(
                      child: Text(
                        RoadSageStrings.helpAndFeedbackDesc,
                        style: Fonts.middleFont,
                        textAlign: TextAlign.center,
                      ),
                      padding: EdgeInsets.all(20.0)),

                  // TODO: possibly convert to TextFormFields?
                  Padding(
                      child: Container(
                        color: const Color.fromARGB(60, 220, 220, 220),
                        child: TextFormField(
                          style: Fonts.middleFont,
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
                              fillColor: Colors.white),
                        ),
                      ),
                      padding: const EdgeInsets.fromLTRB(20, 1.0, 20, 10.0)),
                  Padding(
                      child: Container(
                        color: const Color.fromARGB(60, 220, 220, 220),
                        child: TextFormField(
                          style: Fonts.middleFont,
                          maxLines: 1,
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
                          decoration: const InputDecoration(
                              hintText: RoadSageStrings.formEmail,
                              filled: true,
                              fillColor: Colors.white),
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
                        color: const Color.fromARGB(60, 220, 220, 220),
                        child: TextFormField(
                          style: Fonts.middleFont,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter some feedback';
                            }
                            return null;
                          },
                          maxLines: 13,
                          decoration: const InputDecoration(
                              fillColor: Colors.white,
                              filled: true,
                              hintText: RoadSageStrings.feedbackHint),
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
                                primary: const Color(0xFF0AC0FF),
                                textStyle: const TextStyle(fontSize: 20)),
                            onPressed: () => submit(_formKey),
                            child: const Text(RoadSageStrings.formSubmit),
                          ))),

                  // Contactus
                  getBtnContainer(RoadSageStrings.contactUs, ""),
                  getBtnContainer(RoadSageStrings.faqs, Routes.faq),
                  getBtnContainer(RoadSageStrings.rateUs, "")
                ])),
        color: const Color(0xFFDCDCDC),
        padding: const EdgeInsets.all(0.0),
        alignment: Alignment.center,
      ),
    );
  }

  Widget getBtnContainer(final String txt, String route) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 18.0),
      child: ElevatedButton.icon(
          onPressed: () => Navigator.pushNamed(context, route),
          icon:
              const Icon(Icons.info_outline, color: RoadSageColours.lightBlue),
          style: ButtonStyle(
              padding: MaterialStateProperty.all(
                  const EdgeInsets.symmetric(vertical: 8)),
              backgroundColor: MaterialStateProperty.all(Colors.white)),
          label: Text(
            txt,
            style: Fonts.middleFont,
          )),
    );
  }

  static void submit(GlobalKey<FormState> formKey) {
    formKey.currentState!.save();
    if (formKey.currentState!.validate()) {}
  }
}
