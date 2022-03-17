import 'package:flutter/material.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:permission_handler/permission_handler.dart';

/// Utility function to request permissions or check if they were already granted
Future<bool> checkPermissions() async {
  bool granted = await [
    Permission.location,
    Permission.microphone,
  ]
      .request()
      .then((value) => value.values.every((element) => element.isGranted));

  return granted;
}

/// Utility function to check permissions and then navigate to a [route] or show an [error]
void navigateOrError(String route, String error, BuildContext context) async {
  if (await checkPermissions()) {
    Navigator.pushReplacementNamed(context, route);
  } else {
    Fluttertoast.showToast(msg: translate(error));
  }
}
