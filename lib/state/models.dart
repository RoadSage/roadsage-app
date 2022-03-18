import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:roadsage/constants.dart';
import 'package:roadsage/state/data.dart';
import 'package:shared_preferences/shared_preferences.dart';

// SharedPreferences
final sharedPrefs = FutureProvider<SharedPreferences>(
    (_) async => await SharedPreferences.getInstance());

// General app model --------------------------------------------------

/// Model for storing general application state
class RoadSageModel {
  RoadSageModel(
      {this.loggedIn = false,
      this.firstLaunch = true,
      this.themeMode = ThemeMode.system,
      this.languageCode = "en"});

  // Status
  bool loggedIn;
  bool firstLaunch;
  ThemeMode themeMode;
  String languageCode;

  RoadSageModel copyWith(
      {bool? loggedIn,
      bool? firstLaunch,
      ThemeMode? themeMode,
      String? languageCode}) {
    return RoadSageModel(
        loggedIn: loggedIn ?? this.loggedIn,
        firstLaunch: firstLaunch ?? this.firstLaunch,
        themeMode: themeMode ?? this.themeMode,
        languageCode: languageCode ?? this.languageCode);
  }
}

/// Notifier for subscribing to changes in a RoadSageModel
class RoadSageModelNotifier extends StateNotifier<RoadSageModel> {
  final SharedPreferences? prefs;

  RoadSageModelNotifier(this.prefs) : super(RoadSageModel()) {
    _initPrefs();
  }

  /// Initialize shared preferences
  void _initPrefs() async {
    // Get language setting if it's already stored on the device
    String? lang = prefs?.getString(Constants.prefsLocale);
    if (lang != null) {
      switchLanguage(lang);
    }

    int? themeIndex = prefs?.getInt(Constants.prefsTheme);
    if (themeIndex != null) {
      switchThemeMode(ThemeMode.values[themeIndex]);
    }

    bool? loggedIn = prefs?.getBool(Constants.prefsLoggedIn);
    if (loggedIn != null) {
      switchLoggedIn(loggedIn);
    }

    bool? firstLaunch = prefs?.getBool(Constants.prefsFirstLaunch);
    if (firstLaunch != null) {
      switchFirstLaunch(firstLaunch);
    }
  }

  /// Helper function for switching the login status in the device storage
  void switchLoggedIn(bool value) {
    state = state.copyWith(loggedIn: value);
    prefs?.setBool(Constants.prefsLoggedIn, value);
  }

  void switchFirstLaunch(bool value) {
    state = state.copyWith(firstLaunch: value);
    prefs?.setBool(Constants.prefsFirstLaunch, value);
  }

  void switchThemeMode(ThemeMode value) {
    state = state.copyWith(themeMode: value);
    prefs?.setInt(Constants.prefsTheme, value.index);
  }

  /// No need to directly change prefs - handled by TranslatePreferences
  void switchLanguage(String lang) {
    state = state.copyWith(languageCode: lang);
  }
}

/// Provider object for accessing the RoadSage model
final roadSageModelProvider =
    StateNotifierProvider<RoadSageModelNotifier, RoadSageModel>((ref) {
  final prefs = ref.watch(sharedPrefs).maybeWhen(
        data: (value) => value,
        orElse: () => null,
      );

  if (prefs != null) {}
  return RoadSageModelNotifier(prefs);
});

// Display (display.dart) -----------------------------------------------

class DisplayModel {
  DisplayModel(
      {this.displayStatus = false,
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

// Remote (remote.dart)  -----------------------------------------------

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

// Recents (recents.dart)  -----------------------------------------------

/// Provider object for accessing recents
final recentsProvider = ChangeNotifierProvider<RecentsProvider>((ref) {
  return RecentsProvider(ref);
});

/// Notifier for performing changes to recents and subscribing to them
class RecentsProvider with ChangeNotifier {
  final ChangeNotifierProviderRef? ref;
  List<RoadSageCommand> _recents = [];
  RecentsProvider(this.ref) {
    if (ref != null) getDataFromDb();
  }

  /// Get recents (used in RecentsScreen)
  List<RoadSageCommand> get recents => [..._recents];

  /// Add a new command to recents, both model & database
  void addCommand(RoadSageCommand command) {
    final db = ref!.read(dbProvider).db;
    if (db == null) return;
    _recents.add(command);
    notifyListeners();
    ref!.read(dbProvider).insert(Constants.recentsTableName, command.toMap());
  }

  /// Fetch recents from the database into the model
  Future<void> getDataFromDb() async {
    final db = ref!.read(dbProvider).db;
    if (db == null) return;
    final dataList = await ref!
        .read(dbProvider.notifier)
        .getData(Constants.recentsTableName);
    _recents = dataList.map((e) => RoadSageCommand.fromMap(e)).toList();
    notifyListeners();
  }

  /// Clear recents in the model and database
  void clearRecents() async {
    final db = ref!.read(dbProvider).db;
    if (db == null) return;
    _recents = [];
    notifyListeners();
    await db.delete(Constants.recentsTableName);
  }
}

// TranslatePreferences (for persistent locale switching)
class TranslatePreferences implements ITranslatePreferences {
  @override
  Future<Locale?> getPreferredLocale() async {
    final prefs = await SharedPreferences.getInstance();
    if (!prefs.containsKey(Constants.prefsLocale)) return null;
    var locale = prefs.getString(Constants.prefsLocale);
    return localeFromString(locale!);
  }

  @override
  Future savePreferredLocale(Locale locale) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(Constants.prefsLocale, localeToString(locale));
  }
}
