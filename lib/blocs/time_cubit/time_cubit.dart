import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

part 'time_state.dart';

class TimeCubit extends Cubit<TimeState> {
  TimeCubit() : super(TimeNow());

  void changeTime([TimeOfDay? newTime]) {
    newTime == null ? emit(TimeNow()) : emit(TimeLoaded(newTime));
  }
}
