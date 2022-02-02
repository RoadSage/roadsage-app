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
          child: ListView(children: <Widget>[
            const Padding(
                child: Text(
                  RoadSageStrings.helpAndFeedbackDesc,
                  textAlign: TextAlign.center,
                ),
                padding: EdgeInsets.all(20.0)),

            // TODO: possibly convert to TextFormFields?
            Padding(
                child: Container(
                  color: Theme.of(context).primaryColorLight,
                  child: const TextField(
                    maxLines: 1,
                    decoration: InputDecoration(
                      hintText: RoadSageStrings.formName,
                      filled: true,
                    ),
                  ),
                ),
                padding: const EdgeInsets.fromLTRB(20, 1.0, 20, 10.0)),
            Padding(
                child: Container(
                  color: Theme.of(context).primaryColorLight,
                  child: const TextField(
                    maxLines: 1,
                    decoration: InputDecoration(
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
                  child: const TextField(
                    maxLines: 13,
                    decoration: InputDecoration(
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
                      onPressed: () => submit(),
                      child: const Text(RoadSageStrings.formSubmit),
                    ))),

            // Contact us
            getButtonContainer(RoadSageStrings.contactUs, ""),
            getButtonContainer(RoadSageStrings.faqs, Routes.faq),
            getButtonContainer(RoadSageStrings.rateUs, "")
          ])),
      padding: const EdgeInsets.all(0.0),
      alignment: Alignment.center,
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

  static void submit() {
    // TODO: implement callback
  }
}
