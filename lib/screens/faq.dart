import 'package:flutter/material.dart';
import '../constants.dart';

class FAQScreen extends StatefulWidget {
  const FAQScreen({Key? key}) : super(key: key);

  @override
  State<FAQScreen> createState() => _FAQScreenState();
}

class _FAQScreenState extends State<FAQScreen> {
  @override
  Widget build(BuildContext context) {
    AppBar appBar = AppBar(
      title: const Text(RoadSageStrings.faqs),
      titleSpacing: 20,
      toolbarHeight: 75,
      elevation: 0,
      centerTitle: false,
    );

    return Scaffold(
      appBar: appBar,
      body: Container(
        child: Padding(
          padding: const EdgeInsets.only(top: 28.0),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                const Center(
                  child: Text(
                    "Frequently asked questions",
                    style: TextStyle(
                        fontSize: 22.0,
                        fontWeight: FontWeight.w400,
                        fontFamily: "Roboto"),
                  ),
                ),
                const Padding(
                  child: Text(
                    "Some questions frequently asked by RoadSage customers can be found below. If your issue has not been resolved here please submit your question using the button below and a member of the team will get back to you shortly.",
                    textAlign: TextAlign.center,
                  ),
                  padding: EdgeInsets.all(20.0),
                ),
                Padding(
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      mainAxisSize: MainAxisSize.max,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: <Widget>[
                        Container(
                          child: Column(children: <Widget>[
                            Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                mainAxisSize: MainAxisSize.max,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[
                                  IconButton(
                                    icon: const Icon(Icons.info_outline),
                                    onPressed: () {},
                                    iconSize: 30.0,
                                    color: RoadSageColours.lightBlue,
                                  ),
                                  const Text(
                                    "How do I display custom messages?",
                                    style: TextStyle(
                                        fontSize: 16.0,
                                        color: Colors.black,
                                        fontWeight: FontWeight.w300,
                                        fontFamily: "Roboto"),
                                  )
                                ]),
                            const Icon(
                              Icons.arrow_drop_down,
                              size: 30.0,
                              color: RoadSageColours.lightBlue,
                            ),
                          ]),
                          color: RoadSageColours.lightGrey,
                          padding: const EdgeInsets.all(0.0),
                          alignment: Alignment.center,
                        ),
                      ]),
                  padding: const EdgeInsets.all(24.0),
                ),
                const Spacer(),
                Padding(
                    padding: const EdgeInsets.fromLTRB(20, 20, 20, 30),
                    child: SizedBox(
                        width: double.infinity,
                        height: 50,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              textStyle: const TextStyle(fontSize: 20)),
                          onPressed: () => Navigator.pushNamed(
                              context, Routes.faqSubmitQuestion),
                          child: const Text('Ask Question'),
                        ))),
              ]),
        ),
        padding: const EdgeInsets.all(0.0),
        alignment: Alignment.center,
      ),
    );
  }
}
