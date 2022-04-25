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
}
