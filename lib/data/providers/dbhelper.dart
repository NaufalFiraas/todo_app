import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

import '../models/todo.dart';

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
            title TEXT,
            description TEXT,
            date DATETIME,
            hour INTEGER,
            minute INTEGER,
            category TEXT,
            isFinished BOOLEAN,
          )
        ''');
      },
    );
  }

  Future<void> insertTodo(Todo todo) async {
    final Database db = await dbInstance;

    db.insert(
      'todo_table',
      todo.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<void> updateTodo(Todo todo) async {
    final Database db = await dbInstance;

    db.update(
      'todo_table',
      todo.toMap(),
      where: 'id = ?',
      whereArgs: [todo.id],
    );
  }

  Future<List<Map<String, dynamic>>> getTodo(String? category) async {
    final Database db = await dbInstance;

    final String query = category == null
        ? 'SELECT * FROM todo_table ORDER BY date ASC'
        : 'SELECT * FROM todo_table WHERE category = $category ORDER BY date ASC';

    return await db.rawQuery(query);
  }

  Future<void> deleteTodo(Todo todo) async {
    final Database db = await dbInstance;

    db.delete(
      'todo_table',
      where: 'id = ?',
      whereArgs: [todo.id],
    );
  }
}
