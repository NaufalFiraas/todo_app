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

  setUp(() {
    dbHelper = MockDBHelper();
    todoRepository = TodoRepository(dbHelper);
    todo = Todo(
      id: 0,
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
          .thenAnswer((invocation) => Future.value());
      bool insert = await todoRepository.insertTodo(todo);
      expect(insert, equals(true));
    });
  });
}
