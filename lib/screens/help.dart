import 'package:flutter/material.dart';
import 'package:roadsage/constants.dart';

class HelpScreen extends StatefulWidget {
  const HelpScreen({Key? key}) : super(key: key);

  @override
  State<HelpScreen> createState() => _HelpScreenState();
}

class _HelpScreenState extends State<HelpScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
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
                      child: const TextField(
                        style: Fonts.middleFont,
                        maxLines: 1,
                        decoration: InputDecoration(
                            hintText: RoadSageStrings.formName,
                            filled: true,
                            fillColor: Colors.white),
                      ),
                    ),
                    padding: const EdgeInsets.fromLTRB(20, 1.0, 20, 10.0)),
                Padding(
                    child: Container(
                      color: const Color.fromARGB(60, 220, 220, 220),
                      child: const TextField(
                        style: Fonts.middleFont,
                        maxLines: 1,
                        decoration: InputDecoration(
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
                      child: const TextField(
                        style: Fonts.middleFont,
                        maxLines: 13,
                        decoration: InputDecoration(
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
                          onPressed: () => submit(),
                          child: const Text(RoadSageStrings.formSubmit),
                        ))),

                // Contactus
                getBtnContainer(RoadSageStrings.contactUs, ""),
                getBtnContainer(RoadSageStrings.faqs, ""),
                getBtnContainer(RoadSageStrings.rateUs, "")
              ])),
      color: const Color(0xFFDCDCDC),
      padding: const EdgeInsets.all(0.0),
      alignment: Alignment.center,
    );
  }

  Widget getBtnContainer(final String txt, String route) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 18.0),
      child: ElevatedButton.icon(
          onPressed: () {},
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

  static void submit() {
    // TODO: implement callback
  }
}
