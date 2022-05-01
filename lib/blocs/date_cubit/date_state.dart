part of 'date_cubit.dart';

abstract class DateState extends Equatable {
  final DateTime date;

  const DateState(this.date);
}

class DateNow extends DateState {
  DateNow() : super(DateTime.now());

  @override
  List<Object> get props => [date];
}

class DateLoaded extends DateState {
  const DateLoaded({required DateTime date}) : super(date);

  @override
  List<Object?> get props => [date];
}
