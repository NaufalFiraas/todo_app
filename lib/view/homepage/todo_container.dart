import 'package:flutter/material.dart';
import 'package:todo_app/blocs/checklist_cubit/checklist_cubit.dart';
import 'package:todo_app/blocs/todo_bloc/todo_bloc.dart';
import 'package:todo_app/data/models/todo.dart';
import 'package:todo_app/data/models/todo_reminder.dart';
import 'package:todo_app/view/formpage/form_page.dart';
import 'package:intl/intl.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/view/homepage/notification_settings.dart';
import '../../blocs/reminder_cubit/reminder_cubit.dart';

class TodoContainer extends StatefulWidget {
  final int index;
  final int length;
  final Todo todo;
  final bool isDark;

  const TodoContainer({
    Key? key,
    required this.index,
    required this.length,
    required this.isDark,
    required this.todo,
  }) : super(key: key);

  @override
  State<TodoContainer> createState() => _TodoContainerState();
}

class _TodoContainerState extends State<TodoContainer> {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) =>
              ChecklistCubit()..checklistChange(widget.todo.isFinished),
        ),
        BlocProvider(
          create: (context) => ReminderCubit()
            ..setIconReminderValue(widget.todo.delay)
            ..setAndCancelReminder(TodoReminder(
              widget.todo.id!,
              widget.todo.title,
              widget.todo.delay == 0
                  ? 'Saatnya melaksanakan aktivitas ini'
                  : 'Aktivitas dalam ${widget.todo.delay} menit',
              widget.todo.date,
              widget.todo.delay,
            )),
        ),
      ],
      child: Dismissible(
        key: ObjectKey(widget.todo),
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
                    color: widget.isDark ? Colors.white : Colors.black54,
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
                      context
                          .read<TodoBloc>()
                          .add(TodoDelete(todo: widget.todo));
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
          margin: EdgeInsets.fromLTRB(
            20,
            widget.index == 0 ? 20 : 10,
            20,
            widget.index == widget.length - 1 ? 20 : 10,
          ),
          decoration: BoxDecoration(
            color: widget.isDark ? const Color(0xFFDEE8F5) : Colors.white,
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
                    colors: widget.todo.dateTitle == 'Hari Ini'
                        ? [
                            const Color(0xFF309CFF),
                            const Color(0xFF044D90),
                          ]
                        : widget.todo.dateTitle == 'Besok'
                            ? [
                                const Color(0xFFE2E719),
                                const Color(0xFF044D90),
                              ]
                            : widget.todo.dateTitle == 'Minggu Ini'
                                ? [
                                    const Color(0xFF15F22B),
                                    const Color(0xFF044D90),
                                  ]
                                : widget.todo.dateTitle == 'Minggu Depan'
                                    ? [
                                        const Color(0xFF156009),
                                        const Color(0xFF044D90),
                                      ]
                                    : widget.todo.dateTitle ==
                                            '2 Minggu / Lebih'
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
                  widget.todo.dateTitle,
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
                  if (widget.todo.dateTitle != 'Kadaluwarsa') {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) {
                          return FormPage(isAdd: false, todo: widget.todo);
                        },
                      ),
                    );
                  }
                },
                leading: Builder(builder: (context) {
                  return Checkbox(
                    shape: const StadiumBorder(),
                    activeColor: Colors.amber,
                    value: context.watch<ChecklistCubit>().state.isChecked,
                    onChanged: (newValue) {
                      context.read<ChecklistCubit>().checklistChange(newValue!);
                      addNewChecklistedTodo(
                          context: context, value: newValue, todo: widget.todo);
                    },
                  );
                }),
                title: Text(
                  widget.todo.title,
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
                      widget.todo.description,
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
                      DateFormat('dd-MMM-yyyy').format(widget.todo.date),
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
                      widget.todo.hour.toString().padLeft(2, '0') +
                          ' : ' +
                          widget.todo.minute.toString().padLeft(2, '0'),
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
                      widget.todo.category,
                      style: const TextStyle(
                        fontFamily: 'Patrick Hand',
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: Color(0xFF787875),
                      ),
                    ),
                  ],
                ),
                trailing: Builder(builder: (context2) {
                  ReminderCubit reminderCubit = context2.watch<ReminderCubit>();

                  return IconButton(
                    icon: Icon(
                      reminderCubit.state.isDelay
                          ? widget.todo.dateTitle == 'Kadaluwarsa'
                              ? Icons.notifications_off
                              : Icons.notifications_on
                          : Icons.notifications_off,
                      color: reminderCubit.state.isDelay
                          ? widget.todo.dateTitle == 'Kadaluwarsa'
                              ? Colors.grey
                              : Colors.amber
                          : Colors.grey,
                    ),
                    onPressed: () {
                      if (widget.todo != 'Kadaluwarsa') {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) {
                          return NotificationSettings(
                            reminderCubit: reminderCubit,
                            todo: widget.todo,
                            todoBloc: context.read<TodoBloc>(),
                          );
                        }));
                      }
                    },
                  );
                }),
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
      delay: 0,
    );
    context.read<TodoBloc>().add(TodoUpdate(todo: newTodo, addChecklist: true));
  }
}
