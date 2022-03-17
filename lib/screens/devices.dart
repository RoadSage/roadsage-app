import 'package:flutter/material.dart';
import 'package:roadsage/constants.dart';
import 'package:flutter_translate/flutter_translate.dart';

/// Screen with devices used by the app (remote & display)
class DevicesScreen extends StatefulWidget {
  const DevicesScreen({Key? key}) : super(key: key);

  @override
  State<DevicesScreen> createState() => _DevicesScreenState();
}

class _DevicesScreenState extends State<DevicesScreen> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Expanded(
              child: ListView(
            padding: const EdgeInsets.all(18),
            children: [
              ListTile(
                contentPadding: const EdgeInsets.all(16),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12)),
                title: Text(
                  translate(RoadSageStrings.remote),
                  style: const TextStyle(fontSize: 20),
                ),
                leading: const Icon(
                  Icons.gamepad,
                  size: 38,
                  color: RoadSageColours.lightBlue,
                ),
                tileColor: Theme.of(context).primaryColorLight,
                onTap: () {
                  Navigator.pushNamed(context, Routes.remote);
                },
              ),
              const SizedBox(height: 15),
              ListTile(
                contentPadding: const EdgeInsets.all(16),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12)),
                title: Text(
                  translate(RoadSageStrings.display),
                  style: const TextStyle(fontSize: 20),
                ),
                leading: const Icon(
                  Icons.smart_display_outlined,
                  size: 38,
                  color: RoadSageColours.lightBlue,
                ),
                tileColor: Theme.of(context).primaryColorLight,
                onTap: () {
                  Navigator.pushNamed(context, Routes.display);
                },
              )
            ],
          )),
        ],
      ),
    );
  }
}
