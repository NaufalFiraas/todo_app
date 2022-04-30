part of 'checklist_cubit.dart';

abstract class ChecklistState extends Equatable {
  final bool? isChecked;

  const ChecklistState(this.isChecked);
}

class ChecklistChange extends ChecklistState {
  const ChecklistChange({bool? isChecked}) : super(isChecked);

  @override
  List<bool?> get props => [isChecked];
}
