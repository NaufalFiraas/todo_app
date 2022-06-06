import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DbHelper {
  Database? _db;

  Future<Database> get dbInstance async {
    return _db ?? await dbInit();
  }

  Future<Database> dbInit() async {
    return await openDatabase(
      join(await getDatabasesPath(), 'todo.db'),
      version: 1,
      onCreate: (database, version) {
        return database.execute('''
          CREATE TABLE todo_table(
            id INTEGER PRIMARY KEY,
            dateTitle TEXT,
            title TEXT,
            description TEXT,
            date TEXT,
            hour INTEGER,
            minute INTEGER,
            category TEXT,
            isFinished BOOLEAN
          )
        ''');
      },
    );
  }

  Future<void> insertData(Map<String, dynamic> data) async {
    final Database db = await dbInstance;

    db.insert(
      'todo_table',
      data,
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<void> updateData(Map<String, dynamic> data) async {
    final Database db = await dbInstance;

    db.update(
      'todo_table',
      data,
      where: 'id = ?',
      whereArgs: [data['id']],
    );
  }

  Future<List<Map<String, dynamic>>> getData(String? category) async {
    final Database db = await dbInstance;

    final String query = category == null || category == 'Semua'
        ? 'SELECT * FROM (SELECT * FROM todo_table ORDER BY date) ORDER BY hour,minute;'
        : "SELECT * FROM (SELECT * FROM todo_table WHERE category = '$category' ORDER BY date) ORDER BY hour,minute;";

    return await db.rawQuery(query);
  }

  Future<void> deleteData(Map<String, dynamic> data) async {
    final Database db = await dbInstance;

    db.delete(
      'todo_table',
      where: 'id = ?',
      whereArgs: [data['id']],
    );
  }
}
