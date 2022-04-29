import 'package:flutter/material.dart';
import 'package:todo_app/blocs/category_cubit/category_cubit.dart';
import 'package:todo_app/view/drawer/my_drawer.dart';
import 'package:todo_app/view/formpage/form_page.dart';
import 'package:todo_app/view/homepage/todo_container.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
    print('build home');
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
                        const Text(
                          'Senin',
                          style: TextStyle(
                            fontFamily: 'Patrick Hand',
                            fontSize: 25,
                            fontWeight: FontWeight.w400,
                            color: Colors.white,
                          ),
                        ),
                        const Text(
                          '25-04-2022',
                          style: TextStyle(
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

                            return DropdownButton<String>(
                              items: dropdownMenuBuilder(dropdownMenus),
                              onChanged: (value) {
                                if (value != null) {
                                  categoryCubit.changeCategory(value);
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
            SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  return const TodoContainer(
                    dayTitle: 'Hari Ini',
                    title: 'Judul',
                    description: 'Deskripsi',
                    date: '25-04-2022',
                    hour: 17,
                    minute: 0,
                    category: 'Semua',
                  );
                },
                childCount: 10,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
