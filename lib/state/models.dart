import 'package:flutter_riverpod/flutter_riverpod.dart';

// Display (display.dart)

class DisplayModel {
  DisplayModel(
      {this.displayStatus = true,
      this.sensorStatus = true,
      this.batteryLevel = 68,
      this.adaptiveBrightness = true,
      this.brightnessLevel = 20,
      this.stoppingDistance = 1.5});

  bool displayStatus;
  bool sensorStatus;
  int batteryLevel;
  bool adaptiveBrightness;
  double brightnessLevel;
  double stoppingDistance;

  DisplayModel copyWith(
      {bool? displayStatus,
      bool? sensorStatus,
      int? batteryLevel,
      bool? adaptiveBrightness,
      double? brightnessLevel,
      double? stoppingDistance}) {
    return DisplayModel(
        displayStatus: displayStatus ?? this.displayStatus,
        sensorStatus: sensorStatus ?? this.sensorStatus,
        batteryLevel: batteryLevel ?? this.batteryLevel,
        adaptiveBrightness: adaptiveBrightness ?? this.adaptiveBrightness,
        brightnessLevel: brightnessLevel ?? this.brightnessLevel,
        stoppingDistance: stoppingDistance ?? this.stoppingDistance);
  }
}

class DisplayModelNotifier extends StateNotifier<DisplayModel> {
  DisplayModelNotifier() : super(DisplayModel());

  void switchDisplayStatus(bool value) {
    state = state.copyWith(displayStatus: value);
  }

  void switchSensorStatus(bool value) {
    state = state.copyWith(sensorStatus: value);
  }

  void switchAdaptiveBrightness(bool value) {
    state = state.copyWith(adaptiveBrightness: value);
  }

  void updateBrightnessLevel(double level) {
    state = state.copyWith(brightnessLevel: level);
  }

  void updateStoppingDistance(double distance) {
    state = state.copyWith(stoppingDistance: distance);
  }
}

final displayModelProvider =
    StateNotifierProvider<DisplayModelNotifier, DisplayModel>((ref) {
  return DisplayModelNotifier();
});

// Remote (remote.dart)

class RemoteModel {
  RemoteModel({this.status = true, this.batteryLevel = 65});

  // Status
  bool status;
  int batteryLevel;

  RemoteModel copyWith({bool? status, int? batteryLevel}) {
    return RemoteModel(
        status: status ?? this.status,
        batteryLevel: batteryLevel ?? this.batteryLevel);
  }
}

class RemoteModelNotifier extends StateNotifier<RemoteModel> {
  RemoteModelNotifier() : super(RemoteModel());

  void switchStatus(bool value) {
    state = state.copyWith(status: value);
  }

  void updateBatteryLevel(int value) {
    state = state.copyWith(batteryLevel: value);
  }
}

final remoteModelProvider =
    StateNotifierProvider<RemoteModelNotifier, RemoteModel>((ref) {
  return RemoteModelNotifier();
});
