import 'package:flutter_test/flutter_test.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:todo_app/blocs/date_cubit/date_cubit.dart';

void main() {
  late DateTime date;

  setUp(() {
    date = DateTime.now();
  });

  blocTest<DateCubit, DateState>(
    'Multiple DateTime input case: ',
    build: () => DateCubit(),
    act: (cubit) {
      cubit.changeDate(date.add(const Duration(days: 2)));
      cubit.changeDate(date.add(const Duration(days: 3)));
      cubit.changeDate(date.add(const Duration(days: 4)));
      cubit.changeDate(date.add(const Duration(days: 5)));
    },
    expect: () => <DateState>[
      DateLoaded(date: date.add(const Duration(days: 2))),
      DateLoaded(date: date.add(const Duration(days: 3))),
      DateLoaded(date: date.add(const Duration(days: 4))),
      DateLoaded(date: date.add(const Duration(days: 5))),
    ],
  );
}
