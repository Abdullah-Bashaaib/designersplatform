import 'dart:developer';

import 'package:flutter/services.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class SQLHelper {
  Database? db;

  Future<Database> openDB() async {
    final databasePath = await getDatabasesPath();
    final path = join(databasePath, 'database.db');
    return openDatabase(
      path,
      onCreate: _onCreate,
      onUpgrade: _onUpgrade,
      version: 1,
    );
  }

  Future<void> _onCreate(Database db, int version) async {
    String sqlScript = await loadSqlScript();
    List<String> queries = sqlScript.split(';');
    for (String query in queries) {
      if (query.trim().isNotEmpty) {
        await db.execute(query);
      }
    }
    log("=========> Database Created Successfully <=========");
  }

  _onUpgrade(Database db, int oldVersion, int newVersion) async {}
  Future<String> loadSqlScript() async {
    return await rootBundle.loadString('assets/database/database.db');
  }
}

SQLHelper sqlHelper = SQLHelper();
