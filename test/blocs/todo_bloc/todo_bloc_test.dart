import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:todo_app/blocs/todo_bloc/todo_bloc.dart';
import 'package:todo_app/data/models/todo.dart';
import 'package:todo_app/data/repositories/todo_repository.dart';

class MockTodoRepo extends Mock implements TodoRepository {}

void main() {
  late TodoRepository todoRepo;
  late TodoBloc todoBloc;
  late Todo todo;
  late DateTime date;

  setUp(() {
    date = DateTime.now();
    todoRepo = MockTodoRepo();
    todoBloc = TodoBloc(todoRepo);
    todo = Todo(
      id: 0,
      dateTitle: 'dateTitle test',
      title: 'title test',
      description: 'description test',
      date: date,
      hour: 17,
      minute: 25,
      category: 'category test',
      isFinished: false,
    );
  });

  tearDown(() {
    todoBloc.close();
  });

  test('TodoBloc Initial State: Must be TodoLoading()', () {
    expect(todoBloc.state, TodoLoading());
  });

  group('TodoAdd event test cases: ', () {
    blocTest<TodoBloc, TodoState>(
      'Insert Data Success case: ',
      build: () => TodoBloc(todoRepo),
      act: (bloc) {
        when(() => todoRepo.insertTodo(todo)).thenAnswer(
          (_) => Future.value(true),
        );
        bloc.add(TodoAdd(todo: todo));
      },
      expect: () => <TodoState>[
        TodoLoading(),
        TodoCrudSuccess(),
      ],
    );

    blocTest<TodoBloc, TodoState>(
      'Insert Multiple Data Success Case: ',
      build: () => TodoBloc(todoRepo),
      act: (bloc) {
        when(() => todoRepo.insertTodo(todo)).thenAnswer(
          (_) => Future.value(true),
        );
        bloc.add(TodoAdd(todo: todo));
        bloc.add(TodoAdd(todo: todo));
      },
      expect: () => <TodoState>[
        TodoLoading(),
        TodoCrudSuccess(),
        TodoLoading(),
        TodoCrudSuccess(),
      ],
    );

    blocTest<TodoBloc, TodoState>(
      'Insert Data Failed Case: ',
      build: () => TodoBloc(todoRepo),
      act: (bloc) {
        when(() => todoRepo.insertTodo(todo)).thenAnswer(
          (_) => Future.value(false),
        );
        bloc.add(TodoAdd(todo: todo));
      },
      expect: () => <TodoState>[
        TodoLoading(),
        TodoCrudFailed(),
      ],
    );
  });

  group('TodoUpdate event test cases: ', () {
    blocTest<TodoBloc, TodoState>(
      'Update single data success case: ',
      build: () => TodoBloc(todoRepo),
      act: (bloc) {
        when(() => todoRepo.updateTodo(todo)).thenAnswer(
          (_) => Future.value(true),
        );
        bloc.add(TodoUpdate(todo: todo));
      },
      expect: () => <TodoState>[
        TodoLoading(),
        TodoCrudSuccess(),
      ],
    );

    blocTest<TodoBloc, TodoState>(
      'Update multiple data success case: ',
      build: () => TodoBloc(todoRepo),
      act: (bloc) {
        when(() => todoRepo.updateTodo(todo)).thenAnswer(
          (_) => Future.value(true),
        );
        bloc.add(TodoUpdate(todo: todo));
        bloc.add(TodoUpdate(todo: todo));
      },
      expect: () => <TodoState>[
        TodoLoading(),
        TodoCrudSuccess(),
        TodoLoading(),
        TodoCrudSuccess(),
      ],
    );

    blocTest<TodoBloc, TodoState>(
      'Update checklist only case: ',
      build: () => TodoBloc(todoRepo),
      act: (bloc) {
        when(() => todoRepo.updateTodo(todo))
            .thenAnswer((_) => Future.value(true));
        bloc.add(TodoUpdate(todo: todo, addChecklist: true));
      },
      expect: () => <TodoState>[],
    );

    blocTest<TodoBloc, TodoState>(
      'Update data failed case: ',
      build: () => TodoBloc(todoRepo),
      act: (bloc) {
        when(() => todoRepo.updateTodo(todo)).thenAnswer(
          (_) => Future.value(false),
        );
        bloc.add(TodoUpdate(todo: todo));
      },
      expect: () => <TodoState>[
        TodoLoading(),
        TodoCrudFailed(),
      ],
    );
  });

  group('TodoDelete event test cases: ', () {
    blocTest<TodoBloc, TodoState>(
      'Delete single data success case: ',
      build: () => TodoBloc(todoRepo),
      act: (bloc) {
        when(() => todoRepo.deleteTodo(todo)).thenAnswer(
          (_) => Future.value(true),
        );
        bloc.add(TodoDelete(todo: todo));
      },
      expect: () => <TodoState>[
        TodoLoading(),
        TodoCrudSuccess(),
      ],
    );

    blocTest<TodoBloc, TodoState>(
      'Delete multiple data success case: ',
      build: () => TodoBloc(todoRepo),
      act: (bloc) {
        when(() => todoRepo.deleteTodo(todo)).thenAnswer(
          (_) => Future.value(true),
        );
        bloc.add(TodoDelete(todo: todo));
        bloc.add(TodoDelete(todo: todo));
      },
      expect: () => <TodoState>[
        TodoLoading(),
        TodoCrudSuccess(),
        TodoLoading(),
        TodoCrudSuccess(),
      ],
    );

    blocTest<TodoBloc, TodoState>(
      'Delete data failed case: ',
      build: () => TodoBloc(todoRepo),
      act: (bloc) {
        when(() => todoRepo.deleteTodo(todo)).thenAnswer(
          (_) => Future.value(false),
        );
        bloc.add(TodoDelete(todo: todo));
      },
      expect: () => <TodoState>[
        TodoLoading(),
        TodoCrudFailed(),
      ],
    );
  });

  group('TodoGet event test cases: ', () {
    blocTest<TodoBloc, TodoState>(
      'Empty data loaded case: ',
      build: () => TodoBloc(todoRepo),
      act: (bloc) {
        when(() => todoRepo.getTodo(null)).thenAnswer(
          (_) => Future.value([]),
        );
        bloc.add(const TodoGet());
      },
      expect: () => <TodoState>[
        TodoLoading(),
        const TodoLoaded(todos: []),
      ],
    );

    blocTest<TodoBloc, TodoState>(
      'Single data loaded case: ',
      build: () => TodoBloc(todoRepo),
      act: (bloc) {
        when(() => todoRepo.getTodo(null)).thenAnswer(
          (_) => Future.value([todo, todo, todo]),
        );
        bloc.add(const TodoGet());
      },
      expect: () => <TodoState>[
        TodoLoading(),
        TodoLoaded(todos: [todo, todo, todo]),
      ],
    );

    blocTest<TodoBloc, TodoState>(
      'Get data failed case: ',
      build: () => TodoBloc(todoRepo),
      act: (bloc) {
        when(() => todoRepo.getTodo(null)).thenAnswer(
          (_) => Future.value(null),
        );
        bloc.add(const TodoGet());
      },
      expect: () => <TodoState>[
        TodoLoading(),
        TodoCrudFailed(),
      ],
    );
  });
}
