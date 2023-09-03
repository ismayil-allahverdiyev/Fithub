import 'package:sqflite/sqflite.dart' as sql;

class SQLHelper {
  static Future<void> createTables(sql.Database database) async {
    await database.execute("""CREATE TABLE plans(
        id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
        date INTEGER UNIQUE,
        mood INTEGER,
        waterIntake INTEGER,
        sleepHours INTEGER,
        planList TEXT,
        createdAt TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
      )
      """);
  }

  static Future<sql.Database> db() async {
    return sql.openDatabase(
      'plans.db',
      version: 1,
      onCreate: (sql.Database database, int version) async {
        await createTables(database);
      },
    );
  }

  static Future<int> createItem({
    required int date,
    required int mood,
    required int waterIntake,
    required int sleepHours,
    required String planList,
  }) async {
    final db = await SQLHelper.db();

    final data = {
      'date': date,
      'mood': mood,
      'waterIntake': waterIntake,
      'sleepHours': sleepHours,
      'planList': planList,
    };
    final id = await db.insert('plans', data,
        conflictAlgorithm: sql.ConflictAlgorithm.replace);
    return id;
  }

  static Future<List<Map<String, dynamic>>> getItems() async {
    final db = await SQLHelper.db();
    return db.query('plans', orderBy: "id");
  }

  static Future<List<Map<String, dynamic>>> getItem(int id) async {
    final db = await SQLHelper.db();
    return db.query('plans', where: "id = ?", whereArgs: [id], limit: 1);
  }

  // Update an item by id
  static Future<int> updateItem(
    int id,
    int date,
    int mood,
    int waterIntake,
    int sleepHours,
    String planList,
  ) async {
    final db = await SQLHelper.db();

    final data = {
      'date': date,
      'mood': mood,
      'waterIntake': waterIntake,
      'sleepHours': sleepHours,
      'planList': planList,
    };

    final result =
        await db.update("plans", data, where: "id = ?", whereArgs: [id]);
    return result;
  }

  static Future<void> deleteItem(int id) async {
    final db = await SQLHelper.db();
    try {
      await db.delete("plans", where: "id = ?", whereArgs: [id]);
    } catch (err) {
      print("Something went wrong when deleting an item: $err");
    }
  }
}
