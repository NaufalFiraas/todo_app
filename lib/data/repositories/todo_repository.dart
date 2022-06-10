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
      print(e.toString());
      return false;
    }
  }

  Future<bool> updateTodo(Todo todo) async {
    try {
      await _db.updateData(todo.toMap());
      return true;
    } catch (e) {
      print('Error updateTodo');
      print(e.toString());
      return false;
    }
  }

  Future<List<Todo>?> getTodo(String? category) async {
    try {
      List<Map<String, dynamic>> rawData = await _db.getData(category);
      return List.generate(
        rawData.length,
        (index) {
          String dateTitleValue;
          DateTime date = DateTime.parse(rawData[index]['date']);
          DateTime dateNow = DateTime.now();
          DateTime sameDayNextWeek =
              DateTime.now().add(const Duration(days: 7));
          DateTime firstDateNextWeek = sameDayNextWeek.subtract(
            Duration(days: sameDayNextWeek.weekday - 1),
          );
          DateTime lastDateNextWeek = sameDayNextWeek.add(
            Duration(days: DateTime.daysPerWeek - sameDayNextWeek.weekday),
          );

          if (date.isBefore(dateNow.subtract(const Duration(minutes: 1)))) {
            dateTitleValue = 'Kadaluwarsa';
          } else {
            if (date.day == dateNow.day &&
                date.month == dateNow.month &&
                date.year == dateNow.year) {
              dateTitleValue = 'Hari Ini';
            } else if (date.day == dateNow.add(const Duration(days: 1)).day &&
                date.weekday == dateNow.add(const Duration(days: 1)).weekday) {
              dateTitleValue = 'Besok';
            } else if (date.day > dateNow.add(const Duration(days: 1)).day &&
                date.day < firstDateNextWeek.day) {
              dateTitleValue = 'Minggu Ini';
            } else if (date.day >= firstDateNextWeek.day &&
                date.day <= lastDateNextWeek.day) {
              dateTitleValue = 'Minggu Depan';
            } else {
              dateTitleValue = '2 Minggu / Lebih';
            }
          }

          return Todo(
            id: rawData[index]['id'],
            dateTitle: dateTitleValue,
            title: rawData[index]['title'],
            description: rawData[index]['description'],
            date: date,
            hour: rawData[index]['hour'],
            minute: rawData[index]['minute'],
            category: rawData[index]['category'],
            isFinished: rawData[index]['isFinished'] == 0 ? false : true,
            delay: rawData[index]['delay'] ?? -1,
          );
        },
      );
    } catch (e, stacktrace) {
      print('Error getTodo');
      print(e.toString());
      print(stacktrace.toString());
      return null;
    }
  }

  Future<bool> deleteTodo(Todo todo) async {
    try {
      await _db.deleteData(todo.toMap());
      return true;
    } catch (e) {
      print('Error deleteTodo');
      print(e.toString());
      return false;
    }
  }
}
