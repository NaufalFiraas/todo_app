import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/blocs/todo_bloc/todo_bloc.dart';
import 'package:todo_app/data/providers/dbhelper.dart';
import 'package:todo_app/data/repositories/todo_repository.dart';
import 'package:todo_app/view/homepage/home_page.dart';

void main() {
  runApp(const MyApp());
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
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: HomePage(),
      ),
    );
  }
}
