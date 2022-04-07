import 'package:flutter/foundation.dart';
import 'package:sqflite/sqflite.dart' as sql;

//https://www.kindacode.com/article/flutter-sqlite/
class SQLHelperHealthHabitReminder {

  static Future<sql.Database> db() async {
    return sql.openDatabase(
      'healthHabitReminder.db',
      version: 1,
      onCreate: (sql.Database database, int version) async {
        await createTables(database);
      },
    );
  }

  static Future<void> createTables(sql.Database database) async {
    await database.execute("""CREATE TABLE healthHabitReminders(
        id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
        name TEXT,
        repeat TEXT,
        time TEXT
      )
      """);
  }

  // Create new healthHabit reminder
  static Future<int> createhealthHabitReminder(String name, String repeat, String time) async {
    final db = await SQLHelperHealthHabitReminder.db();

    final data = {'name': name, 'repeat': repeat, 'time': time};
    final id = await db.insert('healthHabitReminders', data,
        conflictAlgorithm: sql.ConflictAlgorithm.replace);
    return id;
  }

  // Read all healthHabit reminders
  static Future<List<Map<String, dynamic>>> gethealthHabitReminders() async {
    final db = await SQLHelperHealthHabitReminder.db();
    return db.query('healthHabitReminders', orderBy: "id");
  }

  // Read a single healthHabit reminder by id
  static Future<List<Map<String, dynamic>>> gethealthHabitReminder(int id) async {
    final db = await SQLHelperHealthHabitReminder.db();
    return db.query('healthHabitReminders', where: "id = ?", whereArgs: [id], limit: 1);
  }

  // Update a healthHabit reminder by id
  static Future<int> updatehealthHabitReminder(
      int id, String name, String repeat, String time) async {
    final db = await SQLHelperHealthHabitReminder.db();

    final data = {
      'name': name,
      'repeat': repeat,
      'time': time,
      //'createdAt': DateTime.now().toString()
    };

    final result =
    await db.update('healthHabitReminders', data, where: "id = ?", whereArgs: [id]);
    return result;
  }

  // Delete healthHabit Reminder
  static Future<void> deletehealthHabitReminder(int id) async {
    final db = await SQLHelperHealthHabitReminder.db();
    try {
      await db.delete("healthHabitReminders", where: "id = ?", whereArgs: [id]);
    } catch (err) {
      debugPrint("Something went wrong when deleting an item: $err");
    }
  }
}