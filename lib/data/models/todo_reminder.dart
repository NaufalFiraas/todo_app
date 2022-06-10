import 'package:equatable/equatable.dart';

class TodoReminder extends Equatable {
  final int id;
  final String title;
  final String body;
  final DateTime time;
  final int delay;

  const TodoReminder(this.id, this.title, this.body, this.time, this.delay);

  @override
  List<Object?> get props => [id, title, body, time, delay];
}
