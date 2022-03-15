import 'dart:convert';
import 'dart:io';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:roadsage/authentication/auth_services.dart';

Future<String?> getSensorReadings(
    String from, String to, AuthClass authClass) async {
  String? token = await authClass.getAuthenticationToken();

  if (token == null) {
    Fluttertoast.showToast(msg: "User is not authenticated");
    return null;
  }

  var queryParams = {'from_date': from, 'to_date': to};
  var url = Uri.http('192.168.1.103:8000', "/sensor-readings/", queryParams);

  var response = await http.get(url, headers: {
    HttpHeaders.authorizationHeader: "Bearer $token",
    HttpHeaders.acceptHeader: "application/json",
    HttpHeaders.contentTypeHeader: "application/json",
  });

  return response.body;
}

Future<String?> addSensorReadings(Map data, AuthClass authClass) async {
  String? token = await authClass.getAuthenticationToken();

  if (token == null) {
    Fluttertoast.showToast(msg: "User is not authenticated");
    return null;
  }

  var url = Uri.http('192.168.1.103:8000', "/sensor-readings/");

  var response = await http.post(url,
      headers: {
        HttpHeaders.authorizationHeader: "Bearer $token",
        HttpHeaders.acceptHeader: "application/json",
        HttpHeaders.contentTypeHeader: "application/json"
      },
      body: json.encode(data));

  return response.body;
}
