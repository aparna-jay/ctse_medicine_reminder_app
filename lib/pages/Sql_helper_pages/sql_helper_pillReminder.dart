import 'package:flutter/foundation.dart';
import 'package:sqflite/sqflite.dart' as sql;

//https://www.kindacode.com/article/flutter-sqlite/
class SQLHelperPillReminder {

  static Future<sql.Database> db() async {
    return sql.openDatabase(
      'pillReminder.db',
      version: 1,
      onCreate: (sql.Database database, int version) async {
        await createTables(database);
      },
    );
  }

  static Future<void> createTables(sql.Database database) async {
    await database.execute("""CREATE TABLE pillReminders(
        id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
        name TEXT,
        dosage TEXT,
        quantity TEXT,
        repeat TEXT,
        time TEXT
      )
      """);
  }

  // Create new pill reminder
  static Future<int> createPillReminder(String name, String dosage, String quantity, String repeat, String time) async {
    final db = await SQLHelperPillReminder.db();

    final data = {'name': name, 'dosage': dosage, 'quantity': quantity, 'repeat': repeat, 'time': time};
    final id = await db.insert('pillReminders', data,
        conflictAlgorithm: sql.ConflictAlgorithm.replace);
    return id;
  }

  // Read all pill reminders
  static Future<List<Map<String, dynamic>>> getPillReminders() async {
    final db = await SQLHelperPillReminder.db();
    return db.query('pillReminders', orderBy: "id");
  }

  // Read a single pill reminder by id
  static Future<List<Map<String, dynamic>>> getPillReminder(int id) async {
    final db = await SQLHelperPillReminder.db();
    return db.query('pillReminders', where: "id = ?", whereArgs: [id], limit: 1);
  }

  // Update a pill reminder by id
  static Future<int> updatePillReminder(
      int id, String name, String dosage, String quantity, String repeat, String time) async {
    final db = await SQLHelperPillReminder.db();

    final data = {
      'name': name,
      'dosage': dosage,
      'quantity': quantity,
      'repeat': repeat,
      'time': time,
      //'createdAt': DateTime.now().toString()
    };

    final result =
    await db.update('pillReminders', data, where: "id = ?", whereArgs: [id]);
    return result;
  }

  // Delete
  static Future<void> deletePillReminder(int id) async {
    final db = await SQLHelperPillReminder.db();
    try {
      await db.delete("pillReminders", where: "id = ?", whereArgs: [id]);
    } catch (err) {
      debugPrint("Something went wrong when deleting an item: $err");
    }
  }
}