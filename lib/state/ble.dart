import 'dart:async';

import 'package:flutter_blue/flutter_blue.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'package:roadsage/state/models.dart';

class BluetoothHandler {
  static BluetoothState? state;
  static FlutterBlue instance = FlutterBlue.instance;
  static BluetoothDevice? bluetoothDevice;
  static DisplayModel? displayModel;
  static bool isScanning = false;

  static void scanDevices() {
    instance.startScan(timeout: const Duration(seconds: 4));
    isScanning = true;

    // Listen to scan results
    instance.scanResults.listen(
      (results) {
        for (ScanResult r in results) {
          if (r.device.name == "Roadsage" && bluetoothDevice != r.device) {
            displayModel?.displayStatus = true;
            r.device.connect();
            bluetoothDevice = r.device;
            Fluttertoast.showToast(msg: "Connected to ${r.device.name}");
            return;
          }
        }
      },
    );

    instance.stopScan();
  }

  static Future<bool> sendText(String text) async {
    if (bluetoothDevice == null) return false;
    // if (text.length > 10) return false;

    List<BluetoothService>? services =
        await bluetoothDevice?.discoverServices();

    services?.forEach((service) async {
      if (service.uuid.toString() == '6e400001-b5a3-f393-e0a9-e50e24dcca9e') {
        for (int i = 0; i < service.characteristics.length; i++) {
          if (service.characteristics[i].uuid.toString() ==
              "6e400002-b5a3-f393-e0a9-e50e24dcca9e") {
            List<int> data = text.codeUnits;
            service.characteristics[i].write(data);
          }
        }
      }
    });

    return true;
  }
}
