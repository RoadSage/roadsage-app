import 'package:flutter/material.dart';
import 'package:roadsage/constants.dart';

import 'package:flutter_translate/flutter_translate.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    AppBar appBar = AppBar(
      title: Text(translate(RoadSageStrings.userProfile)),
      titleSpacing: 20,
      backgroundColor: Colors.transparent,
      toolbarHeight: 75,
      elevation: 0,
      centerTitle: false,
    );

    return Scaffold(
      appBar: appBar,
      body: Padding(
          padding: const EdgeInsets.only(top: 28.0),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Padding(
                    child: Text(
                      translate(RoadSageStrings.formFirstName),
                      style: Theme.of(context).textTheme.bodyText1,
                      textAlign: TextAlign.left,
                    ),
                    padding: const EdgeInsets.all(20.0)),
                Padding(
                    child: Text(
                      translate(RoadSageStrings.formFirstNameExample),
                      style: Theme.of(context).textTheme.headline4,
                      textAlign: TextAlign.left,
                    ),
                    padding: const EdgeInsets.all(20.0)),
                Padding(
                    child: Text(
                      translate(RoadSageStrings.formLastName),
                      style: Theme.of(context).textTheme.bodyText1,
                      textAlign: TextAlign.left,
                    ),
                    padding: const EdgeInsets.all(20.0)),
                Padding(
                    child: Text(
                      translate(RoadSageStrings.formLastNameExample),
                      style: Theme.of(context).textTheme.headline4,
                      textAlign: TextAlign.left,
                    ),
                    padding: const EdgeInsets.all(20.0)),
                Padding(
                    child: Text(
                      translate(RoadSageStrings.formEmail),
                      style: Theme.of(context).textTheme.bodyText1,
                      textAlign: TextAlign.left,
                    ),
                    padding: const EdgeInsets.all(20.0)),
                Padding(
                    child: Text(
                      translate(RoadSageStrings.formEmailExample),
                      style: Theme.of(context).textTheme.headline4,
                      textAlign: TextAlign.left,
                    ),
                    padding: const EdgeInsets.all(20.0)),
                Padding(
                    child: Text(
                      translate(RoadSageStrings.formPhone),
                      style: Theme.of(context).textTheme.bodyText1,
                      textAlign: TextAlign.left,
                    ),
                    padding: const EdgeInsets.all(20.0)),
                Padding(
                    child: Text(
                      translate(RoadSageStrings.formPhoneExample),
                      style: Theme.of(context).textTheme.headline4,
                      textAlign: TextAlign.left,
                    ),
                    padding: const EdgeInsets.all(20.0)),
              ])),
      // color: const Color(0xFFDCDCDC),
    );
  }
}
