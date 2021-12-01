import 'package:flutter/material.dart';
import '../constants.dart';

class SubmitQuestionScreen extends StatefulWidget {
  const SubmitQuestionScreen({Key? key}) : super(key: key);

  @override
  State<SubmitQuestionScreen> createState() => _SubmitQuestionScreenState();
}

class _SubmitQuestionScreenState extends State<SubmitQuestionScreen> {
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
                            color: Color(0xFFffffff),
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
                                      color: Colors.black,
                                      fontWeight: FontWeight.w300,
                                      fontFamily: "Roboto"),
                                )
                              ]),
                          Padding(
                              child: Container(
                                color: const Color.fromARGB(60, 220, 220, 220),
                                child: const TextField(
                                  style: TextStyle(
                                      fontSize: 12.0,
                                      fontWeight: FontWeight.w200,
                                      color: Colors.black,
                                      fontFamily: "Roboto"),
                                  maxLines: 15,
                                  decoration: InputDecoration.collapsed(
                                      hintText: "Enter your question here"),
                                ),
                              ),
                              padding:
                                  const EdgeInsets.fromLTRB(20, 1.0, 20, 10.0))
                        ]),
                        color: const Color(0xFFfafafa),
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
                            primary: const Color(0xFF0AC0FF),
                            textStyle: const TextStyle(fontSize: 20)),
                        onPressed: () => Navigator.pop(context),
                        child: const Text('Submit'),
                      ))),
            ]),
        color: const Color(0xFFDCDCDC),
        padding: const EdgeInsets.all(0.0),
        alignment: Alignment.center,
      ),
    );
  }
}
