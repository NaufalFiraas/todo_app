import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'category_state.dart';

class CategoryCubit extends Cubit<CategoryState> {
  CategoryCubit() : super(const CategoryChanged('Semua'));

  void changeCategory(String newCategory) {
    emit(CategoryChanged(newCategory));
  }
}
