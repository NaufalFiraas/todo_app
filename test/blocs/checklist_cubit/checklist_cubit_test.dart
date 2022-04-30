import 'package:bloc_test/bloc_test.dart';
import 'package:todo_app/blocs/checklist_cubit/checklist_cubit.dart';

void main() {
  blocTest<ChecklistCubit, ChecklistState>(
    'Add checklist case: ',
    build: () => ChecklistCubit(),
    act: (bloc) {
      bloc.checklistChange(true);
    },
    expect: () => <ChecklistState>[const ChecklistChange(isChecked: true)],
  );

  blocTest<ChecklistCubit, ChecklistState>(
    'Unchecklist case: ',
    build: () => ChecklistCubit(),
    act: (bloc) {
      bloc.checklistChange(false);
    },
    expect: () => <ChecklistState>[const ChecklistChange(isChecked: false)],
  );
}
