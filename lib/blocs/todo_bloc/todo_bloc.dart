import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:todo_app/data/models/todo.dart';
import 'package:todo_app/data/repositories/todo_repository.dart';

part 'todo_event.dart';

part 'todo_state.dart';

class TodoBloc extends Bloc<TodoEvent, TodoState> {
  final TodoRepository todoRepo;

  TodoBloc(this.todoRepo) : super(TodoLoading()) {
    on<TodoGet>((event, emit) => _getTodo(event, emit));
    on<TodoAdd>((event, emit) => _addTodo(event, emit));
    on<TodoUpdate>((event, emit) => _updateTodo(event, emit));
    on<TodoDelete>((event, emit) => _deleteTodo(event, emit));
  }

  void _getTodo(TodoGet event, Emitter<TodoState> emit) async {
    emit(TodoLoading());
    final List<Todo>? todoData = await todoRepo.getTodo(event.category);
    todoData == null
        ? emit(TodoLoaded(todos: todoData!))
        : emit(TodoCrudFailed());
  }

  void _addTodo(TodoAdd event, Emitter<TodoState> emit) async {
    emit(TodoLoading());
    final bool addTodo = await todoRepo.insertTodo(event.todo);
    addTodo ? emit(TodoCrudSuccess()) : emit(TodoCrudFailed());
  }

  void _updateTodo(TodoUpdate event, Emitter<TodoState> emit) async {
    emit(TodoLoading());
    final bool updateTodo = await todoRepo.updateTodo(event.todo);
    updateTodo ? emit(TodoCrudSuccess()) : emit(TodoCrudFailed());
  }

  void _deleteTodo(TodoDelete event, Emitter<TodoState> emit) async {
    emit(TodoLoading());
    final bool deleteTodo = await todoRepo.deleteTodo(event.todo);
    deleteTodo ? emit(TodoCrudSuccess()) : emit(TodoCrudFailed());
  }
}
