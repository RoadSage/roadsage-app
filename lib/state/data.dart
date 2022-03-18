import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:roadsage/constants.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart' as path;

/// Data item for storing recents commands in the database and model
class RoadSageCommand {
  late int id;
  late String invocationMethod;
  late String command;
  late DateTime timestamp;

  RoadSageCommand(
      {required this.invocationMethod,
      required this.command,
      required this.timestamp}) {
    id = timestamp.millisecondsSinceEpoch;
  }

  /// Function for converting the object to a database-friendly map
  Map<String, Object?> toMap() {
    return <String, Object?>{
      Constants.apiCommandId: id,
      Constants.apiCommandInvocationMethod: invocationMethod,
      Constants.apiCommandCommand: command,
      Constants.apiCommandTimestamp: timestamp.toString(),
    };
  }

  /// Function for converting a database [map] into a RoadSageCommand object
  RoadSageCommand.fromMap(Map<String, dynamic> map) {
    id = map[Constants.apiCommandId];
    invocationMethod = map[Constants.apiCommandInvocationMethod] as String;
    command = map[Constants.apiCommandCommand] as String;
    timestamp = DateTime.parse(map[Constants.apiCommandTimestamp] as String);
  }
}

/// Provider for accessing the database anywhere in the app
final dbProvider = ChangeNotifierProvider<DataBaseProvider>((ref) {
  return DataBaseProvider();
});

/// Class managing direct interactions with the database
class DataBaseProvider with ChangeNotifier {
  Database? db;

  /// Initialize the database if it doesn't exist alreday
  void init() async {
    final dbPath = await getDatabasesPath();
    db = await openDatabase(path.join(dbPath, Constants.recentsDbFile),
        version: 1, onCreate: (Database db, int version) async {
      await db.execute('''
  create table ${Constants.recentsTableName} (
    ${Constants.apiCommandId} integer primary key,
    ${Constants.apiCommandInvocationMethod} text not null,
    ${Constants.apiCommandCommand} text not null,
    ${Constants.apiCommandTimestamp} text not null
  )
  ''');
    });

    notifyListeners();
  }

  DataBaseProvider() {
    init();
  }

  /// Insert an item described by [data] into [table]
  Future<void> insert(String table, Map<String, Object?> data) async {
    await db!.insert(Constants.recentsTableName, data,
        conflictAlgorithm: ConflictAlgorithm.replace);
    await db!.query(table).then((value) => debugPrint(value.length.toString()));
  }

  // Get all items from [table]
  Future<List<Map<String, dynamic>>> getData(String table) async {
    return await db!.query(table);
  }
}
