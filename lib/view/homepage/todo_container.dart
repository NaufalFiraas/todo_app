import 'package:flutter/material.dart';
import 'package:todo_app/blocs/checklist_cubit/checklist_cubit.dart';
import 'package:todo_app/blocs/todo_bloc/todo_bloc.dart';
import 'package:todo_app/data/models/todo.dart';
import 'package:todo_app/view/formpage/form_page.dart';
import 'package:intl/intl.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TodoContainer extends StatelessWidget {
  final Todo todo;
  final bool isDark;

  const TodoContainer({
    Key? key,
    required this.isDark,
    required this.todo,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ChecklistCubit()..checklistChange(todo.isFinished),
      child: Dismissible(
        key: ObjectKey(todo),
        direction: DismissDirection.endToStart,
        confirmDismiss: (_) {
          return showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                title: const Text(
                  'Hapus',
                  style: TextStyle(
                    fontFamily: 'Patrick Hand',
                    color: Color(0xFF309CFF),
                  ),
                ),
                content: Text(
                  'Yakin Hapus?',
                  style: TextStyle(
                    fontFamily: 'Patrick Hand',
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                    color: isDark ? Colors.white : Colors.black54,
                  ),
                ),
                actions: [
                  TextButton(
                    child: const Text(
                      'Ya',
                      style: TextStyle(
                        fontFamily: 'Patrick Hand',
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                        color: Color(0xFF309CFF),
                      ),
                    ),
                    onPressed: () {
                      context.read<TodoBloc>().add(TodoDelete(todo: todo));
                      context.read<TodoBloc>().add(const TodoGet());
                      Navigator.pop(context);
                    },
                  ),
                  TextButton(
                    child: const Text(
                      'Batal',
                      style: TextStyle(
                        fontFamily: 'Patrick Hand',
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                        color: Color(0xFF309CFF),
                      ),
                    ),
                    onPressed: () {
                      Navigator.pop(context, false);
                    },
                  ),
                ],
              );
            },
          );
        },
        child: Container(
          width: double.infinity,
          margin: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: isDark ? const Color(0xFFDEE8F5) : Colors.white,
            borderRadius: BorderRadius.circular(15),
            boxShadow: const [
              BoxShadow(
                blurRadius: 10,
                spreadRadius: 3,
                color: Colors.black26,
                offset: Offset(0, 0),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.fromLTRB(15, 2, 15, 2),
                width: double.infinity,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: todo.dateTitle == 'Hari Ini'
                        ? [
                            const Color(0xFF309CFF),
                            const Color(0xFF044D90),
                          ]
                        : todo.dateTitle == 'Besok'
                            ? [
                                const Color(0xFFE2E719),
                                const Color(0xFF044D90),
                              ]
                            : todo.dateTitle == 'Minggu Ini'
                                ? [
                                    const Color(0xFF15F22B),
                                    const Color(0xFF044D90),
                                  ]
                                : todo.dateTitle == 'Minggu Depan'
                                    ? [
                                        const Color(0xFF156009),
                                        const Color(0xFF044D90),
                                      ]
                                    : todo.dateTitle == '2 Minggu / Lebih'
                                        ? [
                                            const Color(0xFF273DFF),
                                            const Color(0xFF044D90),
                                          ]
                                        : [
                                            const Color(0xFF4B4B4B),
                                            const Color(0xFF044D90),
                                          ],
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                  ),
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(15),
                    topRight: Radius.circular(15),
                  ),
                ),
                child: Text(
                  todo.dateTitle,
                  style: const TextStyle(
                    fontFamily: 'Patrick Hand',
                    fontSize: 18,
                    fontWeight: FontWeight.w400,
                    color: Colors.white,
                  ),
                ),
              ),
              ListTile(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) {
                        return FormPage(isAdd: false, todo: todo);
                      },
                    ),
                  );
                },
                leading: Builder(builder: (context) {
                  return Checkbox(
                    shape: const StadiumBorder(),
                    activeColor: Colors.amber,
                    value: context.watch<ChecklistCubit>().state.isChecked,
                    onChanged: (value) {
                      context.read<ChecklistCubit>().checklistChange(value!);
                      addNewChecklistedTodo(
                          context: context, value: value, todo: todo);
                    },
                  );
                }),
                title: Text(
                  todo.title,
                  style: const TextStyle(
                    fontFamily: 'Patrick Hand',
                    fontSize: 18,
                    fontWeight: FontWeight.w400,
                    color: Color(0xFF309CFF),
                  ),
                ),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 3,
                    ),
                    Text(
                      todo.description,
                      style: const TextStyle(
                        fontFamily: 'Patrick Hand',
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: Color(0xFF787875),
                      ),
                    ),
                    const SizedBox(
                      height: 3,
                    ),
                    Text(
                      DateFormat('dd-MMM-yyyy').format(todo.date),
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: Color(0xFF787875),
                      ),
                    ),
                    const SizedBox(
                      height: 3,
                    ),
                    Text(
                      todo.hour.toString().padLeft(2, '0') +
                          ' : ' +
                          todo.minute.toString().padLeft(2, '0'),
                      style: const TextStyle(
                        fontFamily: 'Patrick Hand',
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: Color(0xFF787875),
                      ),
                    ),
                    const SizedBox(
                      height: 3,
                    ),
                    Text(
                      todo.category,
                      style: const TextStyle(
                        fontFamily: 'Patrick Hand',
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: Color(0xFF787875),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void addNewChecklistedTodo({
    required BuildContext context,
    required bool value,
    required Todo todo,
  }) {
    Todo newTodo = Todo(
      id: todo.id,
      title: todo.title,
      description: todo.description,
      dateTitle: todo.dateTitle,
      date: todo.date,
      hour: todo.hour,
      minute: todo.minute,
      category: todo.category,
      isFinished: value,
    );
    context.read<TodoBloc>().add(TodoUpdate(todo: newTodo, addChecklist: true));
  }
}
