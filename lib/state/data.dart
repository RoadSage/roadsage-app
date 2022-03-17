import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart' as path;

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

  Map<String, Object?> toMap() {
    return <String, Object?>{
      "id": id,
      "invocation_method": invocationMethod,
      "command": command,
      "timestamp": timestamp.toString(),
    };
  }

  RoadSageCommand.fromMap(Map<String, dynamic> map) {
    id = map['id'];
    invocationMethod = map['invocation_method'] as String;
    command = map['command'] as String;
    timestamp = DateTime.parse(map['timestamp'] as String);
  }
}

final dbProvider = ChangeNotifierProvider<DataBaseProvider>((ref) {
  return DataBaseProvider();
});

class DataBaseProvider with ChangeNotifier {
  static const tableName = 'recentcommands';
  Database? db;

  void init() async {
    final dbPath = await getDatabasesPath();
    db = await openDatabase(path.join(dbPath, 'recents.db'), version: 1,
        onCreate: (Database db, int version) async {
      await db.execute('''
  create table $tableName (
    id integer primary key,
    invocation_method text not null,
    command text not null,
    timestamp text not null
  )
  ''');
    });

    notifyListeners();
  }

  DataBaseProvider() {
    init();
  }

  Future<void> insert(String table, Map<String, Object?> data) async {
    await db!
        .insert(tableName, data, conflictAlgorithm: ConflictAlgorithm.replace);
    debugPrint('stuff inserted');
    await db!.query(table).then((value) => debugPrint(value.length.toString()));
  }

  Future<List<Map<String, dynamic>>> getData(String table) async {
    return await db!.query(table);
  }
}
