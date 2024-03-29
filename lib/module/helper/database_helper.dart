import 'dart:ui';

import 'package:flutter/services.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DataBaseHelper {
  DataBaseHelper._();

  static final DataBaseHelper databaseHelper = DataBaseHelper._();

  Database? db;

  Future<Database?> initDB() async {
    String path = await getDatabasesPath();
    String databasePath = join(path, "studentDB.db");

    print(databasePath);

    db = await openDatabase(databasePath, version: 1,
        onCreate: (Database db, _) async {
      String sql =
          "CREATE TABLE IF NOT EXISTS student (id INTEGER PRIMARY KEY AUTOINCREMENT, name TEXT, age INTEGER, contact TEXT);";

      await db.execute(sql);
    });

    return db;
  }

  Future<void> insertData(
      {required String name, required int age, required String contact}) async {
    db = await initDB();

    String sql = "INSERT INTO student(name,age,contact) VALUES(?,?,?)";
    List values = [name, age, contact];

    await db!.rawInsert(sql, values);
  }

  Future<List<Map<String, Object?>>> fetchAllData() async {
    db = await initDB();

    String sql = "SELECT * FROM student";

    List<Map<String, Object?>> fetchedData = await db!.rawQuery(sql);

    return fetchedData;
  }

  Future<void> updateData(
      {required int id,
      required String name,
      required int age,
      required String contact}) async {
    db = await initDB();

    String sql = "UPDATE student SET name = ?,age = ?,contact = ? WHERE id = ?";
    List values = [name, age, contact, id];

    await db!.rawUpdate(sql, values);
  }

  Future<void> deleteData({required int id}) async {
    db = await initDB();

    String sql = "DELETE FROM student WHERE id = ?";
    List values = [id];

    await db!.rawDelete(sql, values);
  }
}
