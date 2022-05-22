import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:todo_app/blocs/category_cubit/category_cubit.dart';
import 'package:todo_app/blocs/todo_bloc/todo_bloc.dart';
import 'package:todo_app/view/drawer/my_drawer.dart';
import 'package:todo_app/view/formpage/form_page.dart';
import 'package:todo_app/view/homepage/todo_container.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../../blocs/darktheme_cubit/darktheme_cubit.dart';

class HomePage extends StatelessWidget {
  HomePage({Key? key}) : super(key: key);

  final List<String> dropdownMenus = [
    'Belanja',
    'Kerja',
    'Belajar',
    'Travelling',
    'Produktivitas',
    'Hobi',
    'Kuliner',
    'Lainnya...',
    'Semua',
  ];

  final List<String> days = [
    'Senin',
    'Selasa',
    'Rabu',
    'Kamis',
    "Jum'at",
    'Sabtu',
    'Minggu',
  ];

  List<DropdownMenuItem<String>> dropdownMenuBuilder(List<String> menus) {
    return menus.map(
      (e) {
        return DropdownMenuItem<String>(
          child: Text(
            e,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w400,
              color: Colors.white,
              fontFamily: 'Patrick Hand',
            ),
          ),
          value: e,
        );
      },
    ).toList();
  }

  @override
  Widget build(BuildContext context) {
    final DateTime dateNow = DateTime.now();

    return Scaffold(
      endDrawer: const MyDrawer(),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) {
                return const FormPage(isAdd: true);
              },
            ),
          );
        },
        backgroundColor: const Color(0xFF309CFF),
      ),
      body: BlocProvider(
        create: (context) => CategoryCubit(),
        child: CustomScrollView(
          slivers: [
            SliverAppBar(
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(15),
                  bottomRight: Radius.circular(15),
                ),
              ),
              pinned: false,
              floating: true,
              snap: true,
              expandedHeight: 150,
              flexibleSpace: FlexibleSpaceBar(
                background: Container(
                  padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                      colors: [
                        Color(0xFF309CFF),
                        Color(0xFF044D90),
                      ],
                    ),
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(15),
                      bottomRight: Radius.circular(15),
                    ),
                  ),
                  child: SafeArea(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          days[dateNow.weekday - 1],
                          style: const TextStyle(
                            fontFamily: 'Patrick Hand',
                            fontSize: 25,
                            fontWeight: FontWeight.w400,
                            color: Colors.white,
                          ),
                        ),
                        Text(
                          DateFormat('dd-MMM-yyyy').format(dateNow),
                          style: const TextStyle(
                            fontFamily: 'Patrick Hand',
                            fontSize: 18,
                            fontWeight: FontWeight.w400,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(
                          height: 12.5,
                        ),
                        Builder(
                          builder: (context) {
                            final CategoryCubit categoryCubit =
                                context.watch<CategoryCubit>();
                            final TodoBloc todoBloc = context.read<TodoBloc>();

                            return DropdownButton<String>(
                              items: dropdownMenuBuilder(dropdownMenus),
                              onChanged: (value) {
                                if (value != null) {
                                  categoryCubit.changeCategory(value);
                                  todoBloc.add(TodoGet(category: value));
                                }
                              },
                              value: categoryCubit.state.categoryValue,
                              isExpanded: true,
                              dropdownColor: const Color(0xFF309CFF),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Builder(builder: (context) {
              final TodoBloc todoBloc = context.watch<TodoBloc>();
              final DarkthemeChanged darkthemeCubit =
                  context.watch<DarkthemeCubit>().state as DarkthemeChanged;

              if (todoBloc.state is TodoLoading ||
                  todoBloc.state is TodoCrudSuccess) {
                return SliverToBoxAdapter(
                  child: SizedBox(
                    height: MediaQuery.of(context).size.height * 0.75,
                    child: const Center(
                      child: SizedBox(
                        height: 30,
                        width: 30,
                        child: CircularProgressIndicator(
                          color: Colors.lightBlue,
                        ),
                      ),
                    ),
                  ),
                );
              } else if (todoBloc.state is TodoCrudFailed) {
                return SliverToBoxAdapter(
                  child: SizedBox(
                    height: MediaQuery.of(context).size.height * 0.75,
                    child: Center(
                      child: Text(
                        'Terjadi Kesalahan!',
                        style: TextStyle(
                          fontSize: 30,
                          fontFamily: 'Patrick Hand',
                          color: darkthemeCubit.isDark
                              ? Colors.white
                              : Colors.black54,
                        ),
                      ),
                    ),
                  ),
                );
              } else {
                final TodoLoaded todoLoaded = todoBloc.state as TodoLoaded;

                if (todoLoaded.todos.isEmpty) {
                  return SliverToBoxAdapter(
                    child: SizedBox(
                      height: MediaQuery.of(context).size.height * 0.7,
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Lottie.asset(
                              'assets/lotties/empty.json',
                              height: 270,
                            ),
                            Text(
                              'Tidak Ada Data!',
                              style: TextStyle(
                                fontSize: 25,
                                fontFamily: 'Patrick Hand',
                                color: darkthemeCubit.isDark
                                    ? Colors.white
                                    : Colors.black54,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                } else {
                  return SliverList(
                    delegate: SliverChildBuilderDelegate(
                      (context, index) {
                        return TodoContainer(
                          index: index,
                          length: todoLoaded.todos.length,
                          isDark: darkthemeCubit.isDark,
                          todo: todoLoaded.todos[index],
                        );
                      },
                      childCount: todoLoaded.todos.length,
                    ),
                  );
                }
              }
            }),
          ],
        ),
      ),
    );
  }
}
