import 'package:flutter/material.dart';
import 'package:todo_app/blocs/reminder_cubit/reminder_cubit.dart';
import 'package:todo_app/blocs/reminder_icon_cubit/reminder_icon_cubit.dart';
import 'package:todo_app/blocs/todo_bloc/todo_bloc.dart';
import 'package:todo_app/data/models/todo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/models/todo_reminder.dart';

class NotificationSettings extends StatefulWidget {
  final Todo todo;

  const NotificationSettings({Key? key, required this.todo}) : super(key: key);

  @override
  State<NotificationSettings> createState() => _NotificationSettingsState();
}

class _NotificationSettingsState extends State<NotificationSettings> {
  late int _tempValue;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _tempValue = context.watch<ReminderIconCubit>().state.value;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Pengaturan Notifikasi',
          style: const TextStyle(
            fontFamily: 'Patrick Hand',
            fontSize: 25,
            color: Colors.white,
          ),
        ),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(15),
            bottomRight: Radius.circular(15),
          ),
        ),
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color(0xFF309CFF),
                Color(0xFF044D90),
              ],
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
            ),
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(15),
              bottomRight: Radius.circular(15),
            ),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Row(
              children: [
                Radio<int>(
                  value: -1,
                  groupValue: _tempValue,
                  onChanged: (value) {
                    setState(() {
                      _tempValue = value!;
                    });
                  },
                ),
                Text(
                  'Nonaktif',
                  style: TextStyle(
                    fontSize: 20,
                    fontFamily: 'Patrick Hand',
                  ),
                )
              ],
            ),
            Row(
              children: [
                Radio<int>(
                  value: 0,
                  groupValue: _tempValue,
                  onChanged: (value) {
                    setState(() {
                      _tempValue = value!;
                    });
                  },
                ),
                Text(
                  'Saat Waktunya',
                  style: TextStyle(
                    fontSize: 20,
                    fontFamily: 'Patrick Hand',
                  ),
                )
              ],
            ),
            Row(
              children: [
                Radio<int>(
                  value: 5,
                  groupValue: _tempValue,
                  onChanged: (value) {
                    setState(() {
                      _tempValue = value!;
                    });
                  },
                ),
                Text(
                  '5 Menit',
                  style: TextStyle(
                    fontSize: 20,
                    fontFamily: 'Patrick Hand',
                  ),
                )
              ],
            ),
            Row(
              children: [
                Radio<int>(
                  value: 10,
                  groupValue: _tempValue,
                  onChanged: (value) {
                    setState(() {
                      _tempValue = value!;
                    });
                  },
                ),
                Text(
                  '10 Menit',
                  style: TextStyle(
                    fontSize: 20,
                    fontFamily: 'Patrick Hand',
                  ),
                )
              ],
            ),
            Row(
              children: [
                Radio<int>(
                  value: 15,
                  groupValue: _tempValue,
                  onChanged: (value) {
                    setState(() {
                      _tempValue = value!;
                    });
                  },
                ),
                Text(
                  '15 Menit',
                  style: TextStyle(
                    fontSize: 20,
                    fontFamily: 'Patrick Hand',
                  ),
                )
              ],
            ),
            Row(
              children: [
                Radio<int>(
                  value: 30,
                  groupValue: _tempValue,
                  onChanged: (value) {
                    setState(() {
                      _tempValue = value!;
                    });
                  },
                ),
                Text(
                  '30 Menit',
                  style: TextStyle(
                    fontSize: 20,
                    fontFamily: 'Patrick Hand',
                  ),
                )
              ],
            ),
            Row(
              children: [
                Radio<int>(
                  value: 60,
                  groupValue: _tempValue,
                  onChanged: (value) {
                    setState(() {
                      _tempValue = value!;
                    });
                  },
                ),
                Text(
                  '1 Jam',
                  style: TextStyle(
                    fontSize: 20,
                    fontFamily: 'Patrick Hand',
                  ),
                )
              ],
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                  width: 120,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    gradient: const LinearGradient(
                      colors: [
                        Color(0xFF309CFF),
                        Color(0xFF044D90),
                      ],
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                    ),
                  ),
                  child: ElevatedButton(
                    child: Text(
                      'Simpan',
                      style: TextStyle(
                        fontFamily: 'Patrick Hand',
                        fontSize: 22,
                        color: Colors.white,
                      ),
                    ),
                    onPressed: () {
                      radioOnpressed(context, _tempValue);
                      Navigator.pop(context);
                    },
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      primary: Colors.transparent,
                      shadowColor: Colors.transparent,
                    ),
                  ),
                ),
                Container(
                  width: 120,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    gradient: const LinearGradient(
                      colors: [
                        Color(0xFF309CFF),
                        Color(0xFF044D90),
                      ],
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                    ),
                  ),
                  child: ElevatedButton(
                    child: Text(
                      'Kembali',
                      style: TextStyle(
                        fontFamily: 'Patrick Hand',
                        fontSize: 22,
                        color: Colors.white,
                      ),
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      primary: Colors.transparent,
                      shadowColor: Colors.transparent,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void radioOnpressed(BuildContext context, int? value) {
    context.read<ReminderIconCubit>().changeCondition(value!);
    context.read<ReminderCubit>().setAndCancelReminder(
          TodoReminder(
            widget.todo.id!,
            widget.todo.title,
            value == 0
                ? 'Saatnya melaksanakan aktivitas ini'
                : 'Aktivitas dalam $value menit lagi',
            widget.todo.date,
            value,
          ),
        );
    context.read<TodoBloc>().add(TodoUpdate(
            todo: Todo(
          id: widget.todo.id,
          dateTitle: widget.todo.dateTitle,
          title: widget.todo.title,
          description: widget.todo.description,
          date: widget.todo.date,
          hour: widget.todo.hour,
          minute: widget.todo.minute,
          category: widget.todo.category,
          isFinished: widget.todo.isFinished,
          delay: value,
        )));
    context.read<TodoBloc>().add(TodoGet());
  }
}
