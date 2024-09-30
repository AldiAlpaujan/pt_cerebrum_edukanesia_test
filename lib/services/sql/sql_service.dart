import 'package:aldi_test/helper/dialog.dart';
import 'package:aldi_test/services/sql/sql_helper.dart';
import 'package:aldi_test/services/sql/sql_query.dart';
import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart' as sql;

class SqlService {
  static late sql.Database db;

  static _onConfigure(sql.Database db) async {
    await db.execute("PRAGMA foreign_keys = ON");
  }

  static Future<sql.Database> getDatabase() async {
    return db;
  }

  static Future<void> openDatabase() async {
    db = await sql.openDatabase(SqlHelper.dbName, onConfigure: _onConfigure);
  }

  static Future<void> closeDatabase() async {
    await db.close();
  }

  static Future<void> initialize() async {
    await openDatabase();
    await _createTables();
  }

  static Future<void> _createTables() async {
    var database = await getDatabase();
    await database.transaction((txn) async {
      await txn.execute(SqlQuery.craeteTBUser);
    });
  }

  static Future<void> clearDataTable(String tb) async {
    var database = await getDatabase();
    await database.execute("delete from $tb");
  }

  static Future<bool> dbTransaction(
    Future<void> Function(sql.Transaction) transaction,
  ) async {
    try {
      final db = await getDatabase();
      await db.transaction(transaction);
      return true;
    } catch (e) {
      debugPrint(e.toString());
      return false;
    }
  }

  static Future<List<Map<String, dynamic>>> rawQuery(
    String query, [
    List<Object?>? arguments,
  ]) async {
    try {
      final db = await getDatabase();
      final results = await db.rawQuery(query, arguments);
      return results;
    } catch (e) {
      debugPrint(e.toString());
      return [];
    }
  }

  static Future<List<Map<String, dynamic>>> getData(
    String tbName, {
    List<String>? columns,
    String? where,
    List<Object?>? whereArgs,
    String? groupBy,
    String? orderBy,
    String? having,
    int? limit,
  }) async {
    try {
      final db = await getDatabase();
      var data = await db.query(
        tbName,
        columns: columns,
        where: where,
        whereArgs: whereArgs,
        groupBy: groupBy,
        having: having,
        orderBy: orderBy,
        limit: limit,
      );
      return data;
    } catch (e) {
      info(message: "Opps, gagal mengambil data");
      debugPrint(e.toString());
      return [];
    }
  }

  static Future<int?> create(
    String tbName,
    Map<String, dynamic> values,
  ) async {
    try {
      final db = await getDatabase();
      final result = await db.insert(
        tbName,
        values,
        conflictAlgorithm: sql.ConflictAlgorithm.replace,
      );
      return result;
    } catch (e) {
      debugPrint(e.toString());
      info(message: "Opps, gagal menambahkan data");
      return null;
    }
  }

  static Future<bool> update(
    String tbName,
    Map<String, dynamic> values, {
    String? where,
    List<Object?>? whereArgs,
    bool showErrorDialog = true,
  }) async {
    try {
      final db = await getDatabase();
      await db.update(tbName, values, where: where, whereArgs: whereArgs);
      return true;
    } catch (e) {
      debugPrint(e.toString());
      if (showErrorDialog) info(message: "Opps, gagal mengubah data");
      return false;
    }
  }

  static Future<bool> delete(
    String tbName, {
    String? where,
    List<Object?>? whereArgs,
  }) async {
    try {
      final db = await getDatabase();
      await db.delete(
        tbName,
        where: where,
        whereArgs: whereArgs,
      );
      return true;
    } catch (e) {
      debugPrint(e.toString());
      info(message: "Opps, gagal menghapus data");
      return false;
    }
  }
}
