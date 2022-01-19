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
          child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                 const Center(
                  child: Text(  RoadSageStrings.helpAndFeedback, style: Fonts.bigFont),
                ),
                 const Padding(
                  child: Text(
                    RoadSageStrings.helpAndFeedbackDesc,
                    style: Fonts.smallFont,
                    textAlign: TextAlign.center,
                  ),
                  padding: EdgeInsets.all(20.0)),

            Padding(
                child: Container(
                  color:  const Color.fromARGB(60, 220, 220, 220),
                  child:  const TextField(
                    style:  Fonts.middleFont,
                    maxLines: 1,
                    decoration: InputDecoration.collapsed(hintText: RoadSageStrings.name),
                  ),


                ), padding: const EdgeInsets.fromLTRB(20, 1.0, 20, 10.0)
            ),
                Padding(
                    child: Container(
                      color:  const Color.fromARGB(60, 220, 220, 220),
                      child:  const TextField(
                        style:  Fonts.middleFont,
                        maxLines: 1,
                        decoration: InputDecoration.collapsed(hintText: RoadSageStrings.Email),
                      ),


                    ), padding: const EdgeInsets.fromLTRB(20, 1.0, 20, 10.0)
                ),

                const Spacer(),
                const Padding(
                  child: Text(
                    RoadSageStrings.giveFeedback,
                    textAlign: TextAlign.center,
                  ),
                  padding: EdgeInsets.fromLTRB(20, 1.0, 20, 10.0)),

                Padding(
                    child: Container(
                      color:  const Color.fromARGB(60, 220, 220, 220),
                      child:  const TextField(
                        style:  Fonts.smallFont,
                        maxLines: 13,
                        decoration: InputDecoration.collapsed(hintText: RoadSageStrings.feedbackHint),
                      ),


                    ), padding: const EdgeInsets.fromLTRB(20, 1.0, 20, 10.0)
                ),

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
                          child: const Text(RoadSageStrings.submit),
                        ))),

                const Spacer(),
                // Contactus
                getBtnContainer(RoadSageStrings.contactUs),
                getBtnContainer(RoadSageStrings.FAQs),
                getBtnContainer(RoadSageStrings.rateUs)
              ]
          )),
      color: const Color(0xFFDCDCDC),
      padding: const EdgeInsets.all(0.0),
      alignment: Alignment.center,
    );
  }


  Widget getBtnContainer(final String txt){
    return Container(
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
                color: const Color(0xFF0AC0FF),
              ),
               Text(
                txt,
                style: Fonts.middleFont,
              )
            ]),
      ]),
      color: const Color(0xFFfafafa),
      padding: const EdgeInsets.all(0.0),
      alignment: Alignment.center,
    );
  }

  static void submit(){
    // TODO: implement callback
  }
}
