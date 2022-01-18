import 'package:flutter/material.dart';



class Help extends StatefulWidget {
  const Help({Key? key}) : super(key: key);

  @override
  State<Help> createState() => _HelpScreenState();
}

class _HelpScreenState extends State<Help> {

  static const title  = "Your Profile";



  // static ButtonStyle btn =  ElevatedButton.styleFrom(
  // primary:   const Color(0xFF0AC0FF),
  // textStyle:  const TextStyle(fontSize: 20),
  // );

  static const bigFont = TextStyle(
  fontSize: 22.0,
  color: Colors.black,
  fontWeight: FontWeight.w400,
  fontFamily: "Roboto");


  static const middleFont = TextStyle(
      fontSize: 16.0,
      fontWeight: FontWeight.w300,
      color: Colors.black,
      fontFamily: "Roboto");
  
  
  static const smallFont = TextStyle(
      fontSize: 12.0,
      fontWeight: FontWeight.w200,
      color: Colors.black,
      fontFamily: "Roboto");


  @override
  Widget build(BuildContext context) {

    return Container(
      child: Padding(
          padding: const EdgeInsets.only(top: 28.0),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: const <Widget>[
                 Center(
                  child:  Text( title, style: bigFont),
                ),



                 Spacer(),
                 Padding(
                    child: Text(
                      "First Name: ",
                      style: smallFont,
                      textAlign: TextAlign.center,
                    ),
                    padding: EdgeInsets.all(20.0)),

                Padding(
                    child: Text(
                      "Fatma ",
                      style: middleFont,
                      textAlign: TextAlign.center,
                    ),
                    padding: EdgeInsets.all(20.0)),
                Spacer(),
                Padding(
                    child: Text(
                      "Last Name: ",
                      style: smallFont,
                      textAlign: TextAlign.center,
                    ),
                    padding: EdgeInsets.all(20.0)),

                Padding(
                    child: Text(
                      "Sayegh ",
                      style: middleFont,
                      textAlign: TextAlign.center,
                    ),
                    padding: EdgeInsets.all(20.0)),
                Spacer(),
                Padding(
                    child: Text(
                      "Email: ",
                      style: smallFont,
                      textAlign: TextAlign.center,
                    ),
                    padding: EdgeInsets.all(20.0)),

                Padding(
                    child: Text(
                      "mail ",
                      style: middleFont,
                      textAlign: TextAlign.center,
                    ),
                    padding: EdgeInsets.all(20.0)),

                Spacer(),
                Padding(
                    child: Text(
                      "Email: ",
                      style: smallFont,
                      textAlign: TextAlign.center,
                    ),
                    padding: EdgeInsets.all(20.0)),

                Padding(
                    child: Text(
                      "mail ",
                      style: middleFont,
                      textAlign: TextAlign.center,
                    ),
                    padding: EdgeInsets.all(20.0)),

                Spacer(),
                Padding(
                    child: Text(
                      "Phone: ",
                      style: smallFont,
                      textAlign: TextAlign.center,
                    ),
                    padding: EdgeInsets.all(20.0)),

                Padding(
                    child: Text(
                      "phone ",
                      style: middleFont,
                      textAlign: TextAlign.center,
                    ),
                    padding: EdgeInsets.all(20.0)),


              ]
          )),
      color: const Color(0xFFDCDCDC),
      padding: const EdgeInsets.all(0.0),
      alignment: Alignment.center,
    );
  }

}
