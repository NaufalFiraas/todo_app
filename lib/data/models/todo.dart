import 'package:equatable/equatable.dart';

class Todo extends Equatable {
  final int? id;
  final String dateTitle;
  final String title;
  final String description;
  final DateTime date;
  final int hour;
  final int minute;
  final String category;
  final bool isFinished;

  const Todo({
    this.id,
    required this.dateTitle,
    required this.title,
    required this.description,
    required this.date,
    required this.hour,
    required this.minute,
    required this.category,
    required this.isFinished,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'dateTitle': dateTitle,
      'title': title,
      'description': description,
      'date': date.toIso8601String(),
      'hour': hour,
      'minute': minute,
      'category': category,
      'isFinished': isFinished ? 1 : 0,
    };
  }

  @override
  String toString() {
    return 'Todo(id: $id, dateTitle: $dateTitle, title: $title, description: $description, date: $date, hour: $hour, minute: $minute, category: $category, isFinished: $isFinished)';
  }

  @override
  List<Object?> get props => [
        id,
        dateTitle,
        title,
        description,
        date,
        hour,
        minute,
        category,
        isFinished,
      ];
}
