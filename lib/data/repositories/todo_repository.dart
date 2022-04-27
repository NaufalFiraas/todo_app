import 'package:todo_app/data/models/todo.dart';
import 'package:todo_app/data/providers/dbhelper.dart';

class TodoRepository {
  final DbHelper _db;

  const TodoRepository(this._db);

  Future<bool> insertTodo(Todo todo) async {
    try {
      await _db.insertData(todo.toMap());
      return true;
    } catch (e) {
      print('Error insertTodo');
      return false;
    }
  }

  Future<bool> updateTodo(Todo todo) async {
    try {
      await _db.updateData(todo.toMap());
      return true;
    } catch (e) {
      print('Error updateTodo');
      return false;
    }
  }

  Future<List<Todo>?> getTodo(String? category) async {
    try {
      List<Map<String, dynamic>> rawData = await _db.getData(category);
      return List.generate(
        rawData.length,
        (index) {
          return Todo(
            id: rawData[index]['id'],
            title: rawData[index]['title'],
            description: rawData[index]['description'],
            date: rawData[index]['date'],
            hour: rawData[index]['hour'],
            minute: rawData[index]['minute'],
            category: rawData[index]['category'],
            isFinished: rawData[index]['isFinished'],
          );
        },
      );
    } catch (e) {
      print('Error getTodo');
      return null;
    }
  }

  Future<bool> deleteTodo(Todo todo) async {
    try {
      await _db.deleteData(todo.toMap());
      return true;
    } catch (e) {
      print('Error deleteTodo');
      return false;
    }
  }
}
