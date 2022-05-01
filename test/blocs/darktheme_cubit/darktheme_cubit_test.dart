import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:todo_app/blocs/darktheme_cubit/darktheme_cubit.dart';

void main() {
  late DarkthemeCubit darkthemeCubit;

  setUp(() {
    darkthemeCubit = DarkthemeCubit();
  });

  test('Initial condition: ', () {
    expect(darkthemeCubit.state, const DarkthemeChanged(false));
  });

  blocTest<DarkthemeCubit, DarkthemeState>(
    'To Dark Case: ',
    build: () => DarkthemeCubit(),
    act: (cubit) {
      cubit.changeToDark(true);
    },
    expect: () => <DarkthemeState>[
      const DarkthemeChanged(true),
    ],
  );

  blocTest<DarkthemeCubit, DarkthemeState>(
    'To Light Case: ',
    build: () => DarkthemeCubit(),
    act: (cubit) {
      cubit.changeToDark(false);
    },
    expect: () => <DarkthemeState>[
      const DarkthemeChanged(false),
    ],
  );
}
