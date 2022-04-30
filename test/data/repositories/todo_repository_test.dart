import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:todo_app/data/models/todo.dart';
import 'package:todo_app/data/providers/dbhelper.dart';
import 'package:todo_app/data/repositories/todo_repository.dart';

class MockDBHelper extends Mock implements DbHelper {}

void main() {
  late DbHelper dbHelper;
  late TodoRepository todoRepository;
  late Todo todo;
  late DateTime date;

  setUp(() {
    date = DateTime.now();
    dbHelper = MockDBHelper();
    todoRepository = TodoRepository(dbHelper);
    todo = Todo(
      id: 0,
      dateTitle: 'dateTitle test',
      title: 'title test',
      description: 'description test',
      date: DateTime.now(),
      hour: 17,
      minute: 25,
      category: 'category test',
      isFinished: false,
    );
  });

  group('Insert Todo Method Tests: ', () {
    test('Success case: ', () async {
      when(() => dbHelper.insertData(todo.toMap()))
          .thenAnswer((_) => Future.value());
      bool insert = await todoRepository.insertTodo(todo);
      expect(insert, equals(true));
    });

    test('Failed case: ', () async {
      when(() => dbHelper.insertData(todo.toMap())).thenThrow(Exception());
      bool insert = await todoRepository.insertTodo(todo);
      expect(insert, equals(false));
    });
  });

  group('Update Todo Method Tests: ', () {
    test('Success case: ', () async {
      when(() => dbHelper.updateData(todo.toMap()))
          .thenAnswer((_) => Future.value());
      bool update = await todoRepository.updateTodo(todo);
      expect(update, equals(true));
    });

    test('Failed case: ', () async {
      when(() => dbHelper.updateData(todo.toMap())).thenThrow(Exception());
      bool update = await todoRepository.updateTodo(todo);
      expect(update, equals(false));
    });
  });

  group('Delete Todo Method Tests: ', () {
    test('Success case: ', () async {
      when(() => dbHelper.deleteData(todo.toMap()))
          .thenAnswer((_) => Future.value());
      bool delete = await todoRepository.deleteTodo(todo);
      expect(delete, equals(true));
    });

    test('Failed case: ', () async {
      when(() => dbHelper.deleteData(todo.toMap())).thenThrow(Exception());
      bool delete = await todoRepository.deleteTodo(todo);
      expect(delete, equals(false));
    });
  });

  group('Get Todo Method Tests: ', () {
    test('No Data Case: ', () async {
      when(() => dbHelper.getData(null))
          .thenAnswer((invocation) => Future.value([]));
      List<Todo>? getTodo = await todoRepository.getTodo(null);
      expect(getTodo, equals([]));
    });

    test('Single Data Case: ', () async {
      when(() => dbHelper.getData(null)).thenAnswer((_) => Future.value([
            {
              'id': 0,
              'dateTitle': '',
              'title': 'title test',
              'description': 'description test',
              'date': date.add(const Duration(days: 1)),
              'hour': 17,
              'minute': 25,
              'category': 'category test',
              'isFinished': false,
            },
          ]));
      List<Todo>? getTodo = await todoRepository.getTodo(null);
      expect(
        getTodo,
        equals([
          Todo(
            id: 0,
            dateTitle: 'Besok',
            title: 'title test',
            description: 'description test',
            date: date.add(const Duration(days: 1)),
            hour: 17,
            minute: 25,
            category: 'category test',
            isFinished: false,
          ),
        ]),
      );
    });

    test('Multi Data Case: ', () async {
      when(() => dbHelper.getData(null)).thenAnswer((_) => Future.value([
            {
              'id': 0,
              'dateTitle': '',
              'title': 'title test',
              'description': 'description test',
              'date': date.add(const Duration(days: 7)),
              'hour': 17,
              'minute': 25,
              'category': 'category test',
              'isFinished': false,
            },
            {
              'id': 1,
              'dateTitle': '',
              'title': 'title1 test',
              'description': 'description1 test',
              'date': date.add(const Duration(days: 4)),
              'hour': 18,
              'minute': 26,
              'category': 'category1 test',
              'isFinished': true,
            },
            {
              'id': 1,
              'dateTitle': '',
              'title': 'title1 test',
              'description': 'description1 test',
              'date': date.add(const Duration(days: 30)),
              'hour': 18,
              'minute': 26,
              'category': 'category1 test',
              'isFinished': true,
            },
          ]));
      List<Todo>? getTodo = await todoRepository.getTodo(null);
      expect(
          getTodo,
          equals([
            Todo(
              id: 0,
              dateTitle: 'Minggu Depan',
              title: 'title test',
              description: 'description test',
              date: date.add(const Duration(days: 7)),
              hour: 17,
              minute: 25,
              category: 'category test',
              isFinished: false,
            ),
            Todo(
              id: 1,
              dateTitle: 'Minggu Depan',
              title: 'title1 test',
              description: 'description1 test',
              date: date.add(const Duration(days: 4)),
              hour: 18,
              minute: 26,
              category: 'category1 test',
              isFinished: true,
            ),Todo(
              id: 1,
              dateTitle: '2 Minggu / Lebih',
              title: 'title1 test',
              description: 'description1 test',
              date: date.add(const Duration(days: 30)),
              hour: 18,
              minute: 26,
              category: 'category1 test',
              isFinished: true,
            ),

          ]));
    });

    test('Failed Case: ', () async {
      when(() => dbHelper.getData(null)).thenThrow(Exception());
      List<Todo>? getTodo = await todoRepository.getTodo(null);
      expect(getTodo, equals(null));
    });
  });
}
