import 'dart:io';

import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite/sqlite_api.dart';
import 'package:flutterpoke/models.dart';

const String dbName = "FlutterpokeDB";
const String tableFave = "Faves";

class DBProvider {
  DBProvider._();
  static final DBProvider db = DBProvider._();

  static Database _database;
  static Future<Database> get database async {
    if (_database != null) return _database;

    // if _database is null we instantiate it
    _database = await initDB();
    return _database;
  }
}

initDB() async {
  Directory dir = await getApplicationDocumentsDirectory();
  String path = dir.path + dbName;
  return await openDatabase(path, version: 1, onOpen: (db) {},
      onCreate: (Database db, int version) async {
    await db.execute(
        "CREATE TABLE $tableFave (id INTEGER PRIMARY KEY,name TEXT,sprite TEXT)");
  });
}

addFave(FavePoke poke) async {
  final db = await DBProvider.database;
  String raw =
      "INSERT into $tableFave(id, name, sprite) VALUES (${poke.id},\"${poke.name}\",\"${poke.sprite}\")";
  debugPrint(raw);
  return await db.rawInsert(raw);
}

removeFave(int id) async {
  final db = await DBProvider.database;
  db.delete(tableFave, where: "id = ?", whereArgs: [id]);
}

getFaves() async {
  final db = await DBProvider.database;
  var res = await db.query(tableFave);
  List<FavePoke> list =
      res.isNotEmpty ? res.map((c) => FavePoke.fromJson(c)).toList() : [];
  return list;
}

isFaveSaved(int id) async {
  final db = await DBProvider.database;
  var res = await db.query(tableFave, where: "id = ?", whereArgs: [id]);
  return res.isNotEmpty;
}

deleteAll() async {
  final db = await DBProvider.database;
  db.rawDelete("Delete * from $tableFave");
}
