import 'package:sqflite/sqflite.dart' as sql;

class SQL_helper_ReFillReminder {
    static Future<void> createTables(sql.Database database) async {
      await database.execute("""CREATE TABLE items(
        id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
        name TEXT,
        dose TEXT,
        quantity TEXT,
        date TEXT,
        time TEXT
      )
      """);
    }
// id: the id of a item
// name

  static Future<sql.Database> db() async {
    return sql.openDatabase(
      'test.db',
      version: 1,
      onCreate: (sql.Database database, int version) async {
        await createTables(database);
      },
    );
  }

  // Create new item (refill)
  static Future<int> createItem(
      String? name,
      String? dose,
      String? quantity,
      String? date,
      String? time,
      ) async {
    final db = await SQL_helper_ReFillReminder.db();

    final data = {
      'name': name,
      'dose': dose,
      'quantity':quantity,
      'date':date,
      'time':time,
    };
    final id = await db.insert('items', data,
        conflictAlgorithm: sql.ConflictAlgorithm.replace);
    return id;
  }

  // Read all items (refill)
  static Future<List<Map<String, dynamic >>> getItems() async {
    final db = await SQL_helper_ReFillReminder.db();
    return db.query('items', orderBy: "id");
  }

  // Read a single item by id
  static Future<List<Map<String, dynamic>>> getItem(int id) async {
    final db = await SQL_helper_ReFillReminder.db();
    return db.query('items', where: "id = ?", whereArgs: [id], limit: 1);
  }

  // Update an item by id
  static Future<int> updateItem(
      int id,
      String name,
      String dose,
      String quantity,
      // String date,
      // String time,
      ) async {
    final db = await SQL_helper_ReFillReminder.db();

    final data = {
      'name': name,
      'dose': dose,
      'quantity': quantity,
      // 'date': date,
      // 'time': time,
    };

    final result =
    await db.update('items', data, where: "id = ?", whereArgs: [id]);
    return result;
  }


  // Delete
  static Future<void> deleteItem(int id) async {
    final db = await SQL_helper_ReFillReminder.db();
    try {
      await db.delete("items", where: "id = ?", whereArgs: [id]);
    } catch (err) {
      print("Something went wrong when deleting an item: $err");
    }
  }
}