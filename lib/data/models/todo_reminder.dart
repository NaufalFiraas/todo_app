import 'package:equatable/equatable.dart';

class TodoReminder extends Equatable {
  final int id;
  final String title;
  final String body;
  final DateTime time;

  const TodoReminder(this.id, this.title, this.body, this.time);

  @override
  List<Object?> get props => [id, title, body, time];
}
