part of 'todo_bloc.dart';

abstract class TodoEvent extends Equatable {
  const TodoEvent();
}

//get todo (with/without category)
class TodoGet extends TodoEvent {
  final String? category;

  const TodoGet({this.category}) : super();

  @override
  List<Object?> get props => [category];
}

//add todo (Todo)
class TodoAdd extends TodoEvent {
  final Todo todo;

  const TodoAdd({required this.todo}) : super();

  @override
  List<Object?> get props => [todo];
}

//update todo (Todo)
class TodoUpdate extends TodoEvent {
  final Todo todo;

  const TodoUpdate({required this.todo}) : super();

  @override
  List<Object?> get props => [todo];
}

//delete todo (Todo)
class TodoDelete extends TodoEvent {
  final Todo todo;

  const TodoDelete({required this.todo}) : super();

  @override
  List<Object?> get props => [todo];
}
