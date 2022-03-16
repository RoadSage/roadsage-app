import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../constants.dart';

class SubmitQuestionScreen extends StatefulWidget {
  const SubmitQuestionScreen({Key? key}) : super(key: key);

  @override
  State<SubmitQuestionScreen> createState() => _SubmitQuestionScreenState();
}

class _SubmitQuestionScreenState extends State<SubmitQuestionScreen> {
  //This page is responsble for submitting a question
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Padding(
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: const <Widget>[
                      Text(
                        //"RoadSage",
                        " ",
                        style: TextStyle(
                            fontSize: 34.0,
                            fontWeight: FontWeight.w400,
                            fontFamily: "Roboto"),
                      ),
                    ]),
                padding: const EdgeInsets.fromLTRB(25.0, 35.0, 0.0, 0.0),
              ),
              const Padding(
                child: Text(
                  "Please type your question below and a member of the RoadSage team will get back to you shortly.",
                  textAlign: TextAlign.center,
                ),
                padding: EdgeInsets.all(20.0),
              ),
              const Spacer(),
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
                                  "Enter your question here:",
                                  style: TextStyle(
                                      fontSize: 16.0,
                                      fontWeight: FontWeight.w300,
                                      fontFamily: "Roboto"),
                                )
                              ]),
                          const Padding(
                              child: TextField(
                                maxLines: 10,
                                decoration: InputDecoration(
                                    hintText: "Enter your question here"),
                              ),
                              padding: EdgeInsets.fromLTRB(20, 1.0, 20, 10.0))
                        ]),
                        color: Theme.of(context).primaryColorLight,
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
                        onPressed: () {
                          Navigator.pop(context);
                          Fluttertoast.showToast(
                              msg:
                                  "Thank you for submitting your question, a member will get back to you as soon as possible");
                        },
                        child: const Text(
                          'Submit',
                        ),
                      ))),
            ]),
        padding: const EdgeInsets.all(0.0),
        alignment: Alignment.center,
      ),
    );
  }
}
