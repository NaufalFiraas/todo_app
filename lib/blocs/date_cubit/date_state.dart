part of 'date_cubit.dart';

abstract class DateState extends Equatable {
  const DateState();
}

class DateNow extends DateState {
  final DateTime date = DateTime.now();

  @override
  List<Object> get props => [date];
}

class DateLoaded extends DateState {
  final DateTime date;

  const DateLoaded({required this.date}) : super();

  @override
  List<Object?> get props => [date];
}
