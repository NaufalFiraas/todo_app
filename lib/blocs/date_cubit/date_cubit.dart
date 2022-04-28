import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'date_state.dart';

class DateCubit extends Cubit<DateState> {
  DateCubit() : super(DateNow());

  void changeDate([DateTime? newDate]) {
    newDate == null ? emit(DateNow()) : emit(DateLoaded(date: newDate));
  }
}
