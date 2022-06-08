import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:path_provider/path_provider.dart';
import 'package:todo_app/blocs/darktheme_cubit/darktheme_cubit.dart';
import 'package:todo_app/blocs/reminder_cubit/reminder_cubit.dart';
import 'package:todo_app/blocs/todo_bloc/todo_bloc.dart';
import 'package:todo_app/data/providers/dbhelper.dart';
import 'package:todo_app/data/repositories/todo_repository.dart';
import 'package:todo_app/view/homepage/home_page.dart';
import 'package:timezone/data/latest.dart' as tz;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  tz.initializeTimeZones();
  await splashInit();
  final HydratedStorage storage = await HydratedStorage.build(
    storageDirectory: await getApplicationDocumentsDirectory(),
  );
  HydratedBlocOverrides.runZoned(
    () => runApp(const MyApp()),
    storage: storage,
  );
  FlutterNativeSplash.remove();
}

Future<void> splashInit() async {
  await Future.delayed(const Duration(seconds: 2));
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late DbHelper dbHelper;
  late TodoRepository todoRepo;

  @override
  void initState() {
    super.initState();
    dbHelper = DbHelper();
    todoRepo = TodoRepository(dbHelper);
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<TodoBloc>(
          create: (context) => TodoBloc(todoRepo)..add(const TodoGet()),
        ),
        BlocProvider<DarkthemeCubit>(create: (context) => DarkthemeCubit()),
        BlocProvider(
          create: (context) => ReminderCubit()..initNotif(),
        ),
      ],
      child: Builder(builder: (context) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          home: HomePage(),
          theme: ThemeData(
            brightness: context.watch<DarkthemeCubit>().state.isDark
                ? Brightness.dark
                : Brightness.light,
          ),
        );
      }),
    );
  }
}
