import 'package:bloc_test/bloc_test.dart';
import 'package:todo_app/blocs/category_cubit/category_cubit.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late CategoryCubit categoryCubit;

  setUp(() {
    categoryCubit = CategoryCubit();
  });

  test('Initial Condition: ', () {
    expect(categoryCubit.state, const CategoryChanged('Semua'));
  });

  blocTest<CategoryCubit, CategoryState>(
    'Changed category value multiple times: ',
    build: () => CategoryCubit(),
    act: (cubit) {
      cubit.changeCategory('Belanja');
      cubit.changeCategory('Belajar');
      cubit.changeCategory('Kuliner');
    },
    expect: () => <CategoryState>[
      const CategoryChanged('Belanja'),
      const CategoryChanged('Belajar'),
      const CategoryChanged('Kuliner'),
    ],
  );
}
