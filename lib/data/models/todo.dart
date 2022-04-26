class Todo {
  final int? id;
  final String title;
  final String description;
  final DateTime date;
  final int hour;
  final int minute;
  final String category;
  final bool isFinished;

  const Todo({
    this.id,
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
      'title': title,
      'description': description,
      'date': date,
      'hour': hour,
      'minute': minute,
      'category': category,
      'isFinished': isFinished,
    };
  }

  @override
  String toString() {
    return 'Todo(id: $id, title: $title, description: $description, date: $date, hour: $hour, minute: $minute, category: $category, isFinished: $isFinished)';
  }
}
