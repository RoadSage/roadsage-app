import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:roadsage/constants.dart';

class RecentsScreen extends StatefulWidget {
  const RecentsScreen({Key? key}) : super(key: key);

  @override
  State<RecentsScreen> createState() => _RecentsScreenState();
}

class _RecentsScreenState extends State<RecentsScreen> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          Text(
            translate(RoadSageStrings.communication),
            textScaleFactor: 2,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          const SizedBox(
            height: 10,
          ),
          Text(
            translate(RoadSageStrings.checkPreview),
            textScaleFactor: 1.2,
            style: const TextStyle(
              fontWeight: FontWeight.w400,
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          ...[0, 1, 2, 3]
              .map((e) => _buildCard(
                  title: Platform.isAndroid
                      ? translate(RoadSageStrings.googleAssistant)
                      : translate(RoadSageStrings.siri),
                  desc: Platform.isAndroid
                      ? translate(
                          RoadSageStrings.homeAndroidTrySayingEntries[e])
                      : translate(RoadSageStrings.homeIOSTrySayingEntries[e])))
              .toList(),
          _buildCard(
            title: translate(RoadSageStrings.asd),
            desc: translate(RoadSageStrings.mountainSafe),
          ),
        ],
      ),
    );
  }

  _buildCard({
    required String title,
    required String desc,
  }) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ListTile(
        style: ListTileStyle.list,
        title: Text(
          title,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
          ),
          textScaleFactor: 1.05,
        ),
        subtitle: Text(
          desc,
          textScaleFactor: 1.05,
        ),
        trailing: const Text(
          "9/20",
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }
}
