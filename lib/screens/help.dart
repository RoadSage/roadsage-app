import 'package:flutter/material.dart';



class HelpScreen extends StatefulWidget {
  const HelpScreen({Key? key}) : super(key: key);

  @override
  State<HelpScreen> createState() => _HelpScreenState();
}

class _HelpScreenState extends State<HelpScreen> {

  static const title  = "Help & Feedback";
  static const feedback = "Your  feedback is important to help us improve our products";



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
              children: <Widget>[
                 const Center(
                  child: Text( title, style: bigFont),
                ),
                 const Padding(
                  child: Text(
                    feedback,
                    style: smallFont,
                    textAlign: TextAlign.center,
                  ),
                  padding: EdgeInsets.all(20.0)),

            Padding(
                child: Container(
                  color:  const Color.fromARGB(60, 220, 220, 220),
                  child:  const TextField(
                    style:  middleFont,
                    maxLines: 1,
                    decoration: InputDecoration.collapsed(hintText: "Name"),
                  ),


                ), padding: const EdgeInsets.fromLTRB(20, 1.0, 20, 10.0)
            ),
                Padding(
                    child: Container(
                      color:  const Color.fromARGB(60, 220, 220, 220),
                      child:  const TextField(
                        style:  middleFont,
                        maxLines: 1,
                        decoration: InputDecoration.collapsed(hintText: "Email"),
                      ),


                    ), padding: const EdgeInsets.fromLTRB(20, 1.0, 20, 10.0)
                ),

                const Spacer(),
                const Padding(
                  child: Text(
                    "Give  Feedback",
                    textAlign: TextAlign.center,
                  ),
                  padding: EdgeInsets.fromLTRB(20, 1.0, 20, 10.0)),

                Padding(
                    child: Container(
                      color:  const Color.fromARGB(60, 220, 220, 220),
                      child:  const TextField(
                        style:  smallFont,
                        maxLines: 13,
                        decoration: InputDecoration.collapsed(hintText: "Write your feedback here"),
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
                          child: const Text('Submit'),
                        ))),

                const Spacer(),
                // Contactus
                getBtnContainer("Contact us"),
                getBtnContainer("FAQs"),
                getBtnContainer("Rate Us")
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
                style: middleFont,
              )
            ]),
      ]),
      color: const Color(0xFFfafafa),
      padding: const EdgeInsets.all(0.0),
      alignment: Alignment.center,
    );
  }

  static void submit(){
  }
}
