import 'package:sqflite/sqflite.dart' as sql;

class SQLHelper {
  static Future<void> createTables(sql.Database database, String dbName) async {
    if (dbName == "plans") {
      await database.execute("""CREATE TABLE $dbName(
        id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
        date INTEGER UNIQUE,
        mood INTEGER,
        waterIntake INTEGER,
        sleepHours INTEGER,
        planList TEXT,
        createdAt TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
      )
      """);
    } else if (dbName == "dates") {
      await database.execute("""CREATE TABLE $dbName(
        id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
        date INTEGER UNIQUE,
        isFull INTEGER DEFAULT 0,
        createdAt TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
      )
      """);
    }
  }

  static Future<sql.Database> db(String dbName) async {
    return sql.openDatabase(
      '$dbName.db',
      version: 1,
      onCreate: (sql.Database database, int version) async {
        await createTables(database, dbName);
      },
    );
  }

  static Future<int> createItemInPlans({
    required int date,
    required int mood,
    required int waterIntake,
    required int sleepHours,
    required String planList,
  }) async {
    final dbPlans = await SQLHelper.db("plans");
    final dbDates = await SQLHelper.db("dates");

    final data = {
      'date': date,
      'mood': mood,
      'waterIntake': waterIntake,
      'sleepHours': sleepHours,
      'planList': planList,
    };

    final id = await dbPlans.insert("plans", data,
        conflictAlgorithm: sql.ConflictAlgorithm.replace);
    await createItemInDates(date: date, isFull: true);
    return id;
  }

  static Future<int> createItemInDates({
    required int date,
    required bool isFull,
  }) async {
    final db = await SQLHelper.db("dates");

    final data = {
      'date': date,
      'isFull': isFull ? 1 : 0,
    };
    final id = await db.insert("dates", data,
        conflictAlgorithm: sql.ConflictAlgorithm.replace);
    return id;
  }

  static Future<List<Map<String, dynamic>>> getItems(String dbName) async {
    final db = await SQLHelper.db(dbName);
    return db.query(
      dbName,
      orderBy: dbName == "plans" ? "date DESC" : null,
    );
  }

  static Future<List<Map<String, dynamic>>> getItem(
      int id, String dbName) async {
    final db = await SQLHelper.db(dbName);
    return db.query(dbName, where: "id = ?", whereArgs: [id], limit: 1);
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
    final db = await SQLHelper.db("plans");

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
    final db = await SQLHelper.db("plans");
    try {
      await db.delete("plans", where: "id = ?", whereArgs: [id]);
    } catch (err) {
      print("Something went wrong when deleting an item: $err");
    }
  }
}
