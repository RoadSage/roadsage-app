import 'package:flutter/material.dart';
import 'package:roadsage/constants.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:roadsage/state/ble.dart';

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
              Center(
                child: (BluetoothHandler.bluetoothDevice == null)
                    ? Padding(
                        padding: const EdgeInsets.only(top: 10, bottom: 10),
                        child: Text(
                          "Cannot find devices\nPlease connect to RoadSage",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 20,
                            color: Theme.of(context)
                                .primaryTextTheme
                                .bodyLarge
                                ?.color,
                            shadows: const <Shadow>[
                              Shadow(
                                  offset: Offset(0.3, 0.5),
                                  blurRadius: 3,
                                  color: Colors.black),
                            ],
                          ),
                        ),
                      )
                    : null,
              ),
              ListTile(
                enabled: BluetoothHandler.bluetoothDevice != null,
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
                enabled: BluetoothHandler.bluetoothDevice != null,
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
