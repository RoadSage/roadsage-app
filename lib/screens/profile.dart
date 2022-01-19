import 'package:flutter/material.dart';
import 'package:roadsage/constants.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
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
                  child:
                      Text(RoadSageStrings.userProfile, style: Fonts.bigFont),
                ),
                Spacer(),
                Padding(
                    child: Text(
                      RoadSageStrings.formFirstName,
                      style: Fonts.smallFont,
                      textAlign: TextAlign.center,
                    ),
                    padding: EdgeInsets.all(20.0)),
                Padding(
                    child: Text(
                      RoadSageStrings.formFirstNameExample,
                      style: Fonts.middleFont,
                      textAlign: TextAlign.center,
                    ),
                    padding: EdgeInsets.all(20.0)),
                Spacer(),
                Padding(
                    child: Text(
                      RoadSageStrings.formLastName,
                      style: Fonts.smallFont,
                      textAlign: TextAlign.center,
                    ),
                    padding: EdgeInsets.all(20.0)),
                Padding(
                    child: Text(
                      RoadSageStrings.formLastNameExample,
                      style: Fonts.middleFont,
                      textAlign: TextAlign.center,
                    ),
                    padding: EdgeInsets.all(20.0)),
                Spacer(),
                Padding(
                    child: Text(
                      RoadSageStrings.formEmail,
                      style: Fonts.smallFont,
                      textAlign: TextAlign.center,
                    ),
                    padding: EdgeInsets.all(20.0)),
                Padding(
                    child: Text(
                      RoadSageStrings.formEmailExample,
                      style: Fonts.middleFont,
                      textAlign: TextAlign.center,
                    ),
                    padding: EdgeInsets.all(20.0)),
                Spacer(),
                Padding(
                    child: Text(
                      RoadSageStrings.formEmail,
                      style: Fonts.smallFont,
                      textAlign: TextAlign.center,
                    ),
                    padding: EdgeInsets.all(20.0)),
                Padding(
                    child: Text(
                      RoadSageStrings.formEmailExample,
                      style: Fonts.middleFont,
                      textAlign: TextAlign.center,
                    ),
                    padding: EdgeInsets.all(20.0)),
                Spacer(),
                Padding(
                    child: Text(
                      RoadSageStrings.formPhone,
                      style: Fonts.smallFont,
                      textAlign: TextAlign.center,
                    ),
                    padding: EdgeInsets.all(20.0)),
                Padding(
                    child: Text(
                      RoadSageStrings.formPhoneExample,
                      style: Fonts.middleFont,
                      textAlign: TextAlign.center,
                    ),
                    padding: EdgeInsets.all(20.0)),
              ])),
      color: const Color(0xFFDCDCDC),
      padding: const EdgeInsets.all(0.0),
      alignment: Alignment.center,
    );
  }
}
