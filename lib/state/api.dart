import 'dart:convert';
import 'dart:io';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:roadsage/authentication/auth_services.dart';
import 'package:roadsage/constants.dart';

/// Fetch sensor readings between dates [from] and [to] using [authClass] from the API
Future<String?> getSensorReadings(
    String from, String to, AuthClass authClass) async {
  String? token = await authClass.getAuthenticationToken();

  if (token == null) {
    Fluttertoast.showToast(msg: "User is not authenticated");
    return null;
  }

  var queryParams = {'from_date': from, 'to_date': to};
  var url =
      Uri.http(Constants.webServerAddress, "/sensor-readings/", queryParams);

  var response = await http.get(url, headers: {
    HttpHeaders.authorizationHeader: "Bearer $token",
    HttpHeaders.acceptHeader: "application/json",
    HttpHeaders.contentTypeHeader: "application/json",
  });

  return response.body;
}

/// Post sensor readings encoded in [data] to the API using [authClass]
Future<String?> addSensorReadings(Map data, AuthClass authClass) async {
  String? token = await authClass.getAuthenticationToken();

  if (token == null) {
    Fluttertoast.showToast(msg: "User is not authenticated");
    return null;
  }

  var url = Uri.http(Constants.webServerAddress, "/sensor-readings/");

  var response = await http.post(url,
      headers: {
        HttpHeaders.authorizationHeader: "Bearer $token",
        HttpHeaders.acceptHeader: "application/json",
        HttpHeaders.contentTypeHeader: "application/json"
      },
      body: json.encode(data));

  return response.body;
}

/// Send a recents entry with [invocation], [query] and [timestamp] to the API using [authClass]
Future<void> addAppCommand(String invocation, String query, DateTime timestamp,
    AuthClass authClass) async {
  String? token = await authClass.getAuthenticationToken();

  if (token == null) {
    Fluttertoast.showToast(msg: "User is not authenticated");
    return;
  }

  // Encode the timestamp for the API
  String timestring = timestamp.toString().replaceAll(' ', 'T');
  timestring = timestring.substring(0, timestring.length - 3) + 'Z';

  // Combine all arguments for the API
  Map data = {
    'timestamp': timestring,
    'command': translate(query),
    'invocation_method':
        (invocation == RoadSageStrings.homeScreenButton) ? "touch" : "voice",
  };

  var url = Uri.http(Constants.webServerAddress, "/app-commands/");

  await http
      .post(url,
          headers: {
            HttpHeaders.authorizationHeader: "Bearer $token",
            HttpHeaders.acceptHeader: "application/json",
            HttpHeaders.contentTypeHeader: "application/json"
          },
          body: json.encode([data]))
      .then((value) {})
      .onError((error, stackTrace) {});
}
