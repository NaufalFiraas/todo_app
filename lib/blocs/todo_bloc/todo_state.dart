part of 'todo_bloc.dart';

abstract class TodoState extends Equatable {
  const TodoState();
}

//Loading
class TodoLoading extends TodoState {
  @override
  List<Object?> get props => [];
}

//Loaded (List<Todo>)
class TodoLoaded extends TodoState {
  final List<Todo> todos;

  const TodoLoaded({required this.todos}) : super();

  @override
  List<Object?> get props => [todos];
}

//Success Crud
class TodoCrudSuccess extends TodoState {
  @override
  List<Object?> get props => [];
}

//Failed Crud
class TodoCrudFailed extends TodoState {
  @override
  List<Object?> get props => [];
}
