import 'package:flutter/services.dart';

import 'dart:async';
import 'constants.dart';

import 'package:roadsage/state/ble.dart';

/*
Implementation adapted from
https://github.com/myriky/flutter_siri_suggestions/blob/master/lib/flutter_siri_suggestions.dart
 */
typedef MessageHandler = Future<dynamic> Function(Map<String, dynamic> message);

class FlutterSiriActivity {
  /// This is the data model representing the flutter activites of Siri.
  const FlutterSiriActivity(
    this.title,
    this.key, {
    this.contentDescription,
    this.isEligibleForSearch = true,
    this.isEligibleForPrediction = true,
    this.suggestedInvocationPhrase = "",
  });

  final String title;
  final String key;
  final String? contentDescription;
  final bool isEligibleForSearch;
  final bool isEligibleForPrediction;
  final String suggestedInvocationPhrase;
}

class SiriSuggestions {
  SiriSuggestions();

  MessageHandler? _onLaunch;
  Map<String, dynamic>? retryActivity;

  final MethodChannel _channel = const MethodChannel('siri_suggestions');

  /// Create a suggestion
  Future<String> buildActivity(FlutterSiriActivity activity) async {
    ///This function is used to invoke the native method of the ios for Siri enbling.
    return await _channel.invokeMethod('becomeCurrent', <String, Object?>{
      'title': activity.title,
      Constants.siriSuggestionKey: activity.key,
      'contentDescription': activity.contentDescription,
      'isEligibleForSearch': activity.isEligibleForSearch,
      'isEligibleForPrediction': activity.isEligibleForPrediction,
      'suggestedInvocationPhrase': activity.suggestedInvocationPhrase,
    });
  }

  void addSuggestion(String name, String actionKey, bool search, bool predict,
      String desc, String phrase) async {
    ///This function is used to add a suggestion to the backend.
    await buildActivity(FlutterSiriActivity(name, actionKey,
        isEligibleForSearch: search,
        isEligibleForPrediction: predict,
        contentDescription: desc,
        suggestedInvocationPhrase: phrase));
  }

  void addEzSuggestion(String actionKey, String desc, String phrase) async {
    BluetoothHandler.sendText(phrase);
    addSuggestion(
        actionKey + " suggestion", actionKey, true, true, desc, phrase);
  }

  /// Configure the calls for each suggestion.
  void configure({required MessageHandler onLaunch}) {
    _onLaunch = onLaunch;
    _channel.setMethodCallHandler(_handleMethod);
  }

  Future<void> retryLaunchWithActivity() async {
    if (retryActivity != null) {
      _onLaunch!(retryActivity!);
      retryActivity = null;
    }
  }

  Future<dynamic> _handleMethod(MethodCall call) async {
    ///Here we have written all the event handlers to handle the evennt when a particular command is said
    switch (call.method) {
      case "onLaunch":
        return _onLaunch!(call.arguments.cast<String, dynamic>());
      case "failedToLaunchWithActivity":
        retryActivity = call.arguments.cast<String, dynamic>();
        break;
      default:
        throw UnsupportedError("Unrecognized JSON message");
    }
  }
}
