import 'package:flutter/material.dart';
import 'package:roadsage/constants.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter_blue/flutter_blue.dart';

class DevicesScreen extends StatefulWidget {
  const DevicesScreen({Key? key}) : super(key: key);

  @override
  State<DevicesScreen> createState() => _DevicesScreenState();
}

class _DevicesScreenState extends State<DevicesScreen> {
  @override
  void initState() {
    FlutterBlue flutterBlue = FlutterBlue.instance;

    flutterBlue.startScan(timeout: Duration(seconds: 4));

    Fluttertoast.showToast(msg: "Scanning for Bluetooth devices..");
    // Listen to scan results
    var subscription = flutterBlue.scanResults.listen((results) {
      // do something with scan results
      print('listening');
      for (ScanResult r in results) {
        print('${r.device.name} found! rssi: ${r.rssi}');
        Fluttertoast.showToast(msg: "${r.device.name} found!");
      }
    });

    subscription.onDone(() {
      print('listening done');
    });

    // Stop scanning
    flutterBlue.stopScan();

    super.initState();
  }

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
                title: const Text(
                  RoadSageStrings.remote,
                  style: TextStyle(fontSize: 20),
                ),
                leading: const Icon(
                  Icons.gamepad,
                  size: 38,
                  color: RoadSageColours.lightBlue,
                ),
                tileColor: Colors.white,
                onTap: () {
                  Navigator.pushNamed(context, Routes.remote);
                },
              ),
              const SizedBox(height: 15),
              ListTile(
                contentPadding: const EdgeInsets.all(16),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12)),
                title: const Text(
                  RoadSageStrings.display,
                  style: TextStyle(fontSize: 20),
                ),
                leading: const Icon(
                  Icons.smart_display_outlined,
                  size: 38,
                  color: RoadSageColours.lightBlue,
                ),
                tileColor: Colors.white,
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
