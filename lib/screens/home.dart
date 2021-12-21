import 'package:flutter/material.dart';
import 'package:roadsage/constants.dart';

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
            child: Column(children: const <Widget>[
              Icon(Icons.mic_none, size: 60),
              Text(
                RoadSageStrings.trySaying,
                style: TextStyle(fontWeight: FontWeight.w500, fontSize: 18),
              ),
            ]),
          ),
          Expanded(
            child: ListView.separated(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              itemCount: RoadSageStrings.homeAndroidTrySayingEntries.length,
              itemBuilder: (BuildContext context, int index) {
                return ListTile(
                  contentPadding: const EdgeInsets.all(18),
                  leading: const Icon(Icons.message_outlined,
                      size: 28, color: RoadSageColours.lightBlue),
                  onTap: () {},
                  title: Text(
                    RoadSageStrings.homeAndroidTrySayingEntries[index],
                    style: const TextStyle(color: Colors.black, shadows: []),
                  ),
                  tileColor: Colors.white,
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
