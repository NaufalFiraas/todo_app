import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:todo_app/blocs/time_cubit/time_cubit.dart';

void main() {
  late TimeOfDay time;

  setUp(() {
    time = TimeOfDay.now();
  });

  blocTest<TimeCubit, TimeState>(
    'Add multiple time case: ',
    build: () => TimeCubit(),
    act: (cubit) {
      cubit.changeTime();
      cubit.changeTime(time);
      cubit.changeTime(time.replacing(hour: 8, minute: 5));
      cubit.changeTime(time.replacing(hour: 13, minute: 20));
      cubit.changeTime();
    },
    expect: () => <TimeState>[
      TimeNow(),
      TimeLoaded(time),
      TimeLoaded(time.replacing(hour: 8, minute: 5)),
      TimeLoaded(time.replacing(hour: 13, minute: 20)),
      TimeNow(),
    ],
  );
}
