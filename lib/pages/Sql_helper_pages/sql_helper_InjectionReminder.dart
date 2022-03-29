import 'package:flutter/foundation.dart';
import 'package:sqflite/sqflite.dart' as sql;

class SQLHelperInjectionReminder {

  static Future<sql.Database> db() async {
    return sql.openDatabase(
      'InjectionReminder.db',
      version: 1,
      onCreate: (sql.Database database, int version) async {
        await createTables(database);
      },
    );
  }
  // Create new Injection reminder table
  static Future<void> createTables(sql.Database database) async {
    await database.execute("""CREATE TABLE injectionReminders(
        id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
        injectionName TEXT,
        dosage TEXT,
        quantity TEXT,
        repeat TEXT,
        time TEXT
      )
      """);
  }

  // Create new Injection reminder
  static Future<int> createInjectionReminder(String injectionName, String dosage, String quantity, String repeat, String time) async {
    final db = await SQLHelperInjectionReminder.db();

    final data = {'injectionName': injectionName, 'dosage': dosage, 'quantity': quantity, 'repeat': repeat, 'time': time};
    final id = await db.insert('injectionReminders', data,
        conflictAlgorithm: sql.ConflictAlgorithm.replace);
    return id;
  }

  // Read all Injection reminders
  static Future<List<Map<String, dynamic>>> getInjectionReminders() async {
    final db = await SQLHelperInjectionReminder.db();
    return db.query('injectionReminders', orderBy: "id");
  }

  // Read a single Injection reminder by id
  static Future<List<Map<String, dynamic>>> getInjectionReminder(int id) async {
    final db = await SQLHelperInjectionReminder.db();
    return db.query('injectionReminders', where: "id = ?", whereArgs: [id], limit: 1);
  }

  // Update a Injection reminder by id
  static Future<int> updateInjectionReminder(
      int id, String injectionName, String dosage, String quantity, String repeat, String time) async {
    final db = await SQLHelperInjectionReminder.db();

    final data = {
      'injectionName': injectionName,
      'dosage': dosage,
      'quantity': quantity,
      'repeat': repeat,
      'time': time,
      //'createdAt': DateTime.now().toString()
    };

    final result =
    await db.update('injectionReminders', data, where: "id = ?", whereArgs: [id]);
    return result;
  }

  // Delete Injection reminder by id
  static Future<void> deleteInjectionReminder(int id) async {
    final db = await SQLHelperInjectionReminder.db();
    try {
      await db.delete("injectionReminders", where: "id = ?", whereArgs: [id]);
    } catch (err) {
      debugPrint("Something went wrong when deleting an item: $err");
    }
  }
}