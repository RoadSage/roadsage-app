import 'package:flutter/material.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:permission_handler/permission_handler.dart';

Future<bool> checkPermissions() async {
  //This is the page related to ask for permission of the applixation
  bool granted = await [
    Permission.location,
    Permission.microphone,
  ]
      .request()
      .then((value) => value.values.every((element) => element.isGranted));

  return granted;
}

void navigateOrError(String route, String error, BuildContext context) async {
  if (await checkPermissions()) {
    Navigator.pushReplacementNamed(context, route);
  } else {
    Fluttertoast.showToast(msg: translate(error));
  }
}
