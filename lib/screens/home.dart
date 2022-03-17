import 'package:flutter/material.dart';
import 'package:roadsage/constants.dart';
import 'dart:io' show Platform;
import 'package:flutter_translate/flutter_translate.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Container(
            padding: const EdgeInsets.only(top: 20),
            height: 150,
            child: Column(children: <Widget>[
              const Icon(Icons.mic_none, size: 60),
              Text(
                translate(RoadSageStrings.trySaying),
                style:
                    const TextStyle(fontWeight: FontWeight.w500, fontSize: 18),
              ),
            ]),
          ),
          Expanded(
            child: ListView.separated(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              itemCount: (Platform.isAndroid)
                  ? RoadSageStrings.homeAndroidTrySayingEntries.length
                  : RoadSageStrings.homeIOSTrySayingEntries.length,
              itemBuilder: (BuildContext context, int index) {
                return ListTile(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12)),
                  contentPadding: const EdgeInsets.all(18),
                  leading: const Icon(Icons.message_outlined,
                      size: 28, color: RoadSageColours.lightBlue),
                  onTap: () {},
                  title: Text(
                    (Platform.isAndroid)
                        ? translate(
                            RoadSageStrings.homeAndroidTrySayingEntries[index])
                        : translate(
                            RoadSageStrings.homeIOSTrySayingEntries[index]),
                  ),
                  tileColor: Theme.of(context).primaryColorLight,
                );
              },
              separatorBuilder: (BuildContext context, int index) =>
                  const SizedBox(height: 15),
            ),
          ),
        ],
      ),
    );
  }
}
