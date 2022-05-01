import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'checklist_state.dart';

class ChecklistCubit extends Cubit<ChecklistState> {
  ChecklistCubit() : super(const ChecklistChange());

  void checklistChange(bool value) {
    emit(ChecklistChange(isChecked: value));
  }
}
