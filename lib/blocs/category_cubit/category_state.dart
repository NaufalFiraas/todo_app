part of 'category_cubit.dart';

abstract class CategoryState extends Equatable {
  final String categoryValue;

  const CategoryState(this.categoryValue);
}

class CategoryChanged extends CategoryState {
  const CategoryChanged(String categoryValue) : super(categoryValue);

  @override
  List<Object?> get props => [categoryValue];
}
