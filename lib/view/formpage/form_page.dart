import 'package:flutter/material.dart';
import 'package:todo_app/blocs/date_cubit/date_cubit.dart';
import 'package:todo_app/blocs/time_cubit/time_cubit.dart';
import 'package:todo_app/data/models/todo.dart';
import 'package:todo_app/view/formpage/activity_description_form.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class FormPage extends StatefulWidget {
  final bool isAdd;
  final Todo? todo;

  const FormPage({
    Key? key,
    required this.isAdd,
    this.todo,
  }) : super(key: key);

  @override
  State<FormPage> createState() => _FormPageState();
}

class _FormPageState extends State<FormPage> {
  final TextEditingController activityController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();

    /// kalau masuk sebagai edit, set activity dan description controller sesuai todo yang masuk:
    if (!widget.isAdd) {
      activityController.text = widget.todo!.title.toString();
      descriptionController.text = widget.todo!.description.toString();
    }
  }

  @override
  void didChangeDependencies() {
    /// kalau masuk sebagai edit, set date sesuai todo yang masuk:
    if (!widget.isAdd) {
      context.read<DateCubit>().changeDate(widget.todo!.date);
      context.read<TimeCubit>().changeTime(
          TimeOfDay(hour: widget.todo!.hour, minute: widget.todo!.minute));
    }
    super.didChangeDependencies();
  }

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
          value: e,
          child: Text(
            e,
            style: const TextStyle(
              fontFamily: 'Patrick Hand',
              fontSize: 16,
              color: Colors.black54,
            ),
          ),
        );
      },
    ).toList();
  }

  @override
  Widget build(BuildContext context) {
    final DateCubit dateCubit = context.watch<DateCubit>();
    final TimeCubit timeCubit = context.watch<TimeCubit>();

    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.isAdd ? 'Tambah Todo' : 'Edit Todo',
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
      body: SingleChildScrollView(
        child: Form(
          key: formKey,
          child: Column(
            children: [
              const SizedBox(
                height: 10,
              ),
              Container(
                margin: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ActivityDescriptionForm(
                      controller: activityController,
                      title: 'Aktivitas:',
                      validation: (value) {
                        if (value == '') {
                          return 'Wajib diisi!';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    ActivityDescriptionForm(
                      controller: descriptionController,
                      title: 'Deskripsi:',
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    const Text(
                      'Tanggal:',
                      style: TextStyle(
                        fontSize: 18,
                        fontFamily: 'Patrick Hand',
                        color: Color(0xFF309CFF),
                      ),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    GestureDetector(
                      child: Text(
                        DateFormat('dd/MMM/yyyy').format(dateCubit.state.date),
                        style: const TextStyle(
                          fontSize: 16,
                          fontFamily: 'Patrick Hand',
                          color: Colors.black54,
                        ),
                      ),
                      onTap: () {
                        showDatePicker(
                          context: context,
                          firstDate: DateTime.now(),
                          initialDate: dateCubit.state.date,
                          lastDate:
                              DateTime.now().add(const Duration(days: 365)),
                        ).then((value) => dateCubit.changeDate(value));
                      },
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    const Text(
                      'Jam',
                      style: TextStyle(
                        fontFamily: 'Patrick Hand',
                        fontSize: 18,
                        color: Color(0xFF309CFF),
                      ),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    GestureDetector(
                      child: Text(
                        timeCubit.state.time.hour.toString().padLeft(2, '0') +
                            ' : ' +
                            timeCubit.state.time.minute
                                .toString()
                                .padLeft(2, '0'),
                        style: const TextStyle(
                          fontFamily: 'Patrick Hand',
                          fontSize: 16,
                          color: Colors.black54,
                        ),
                      ),
                      onTap: () {
                        showTimePicker(
                          context: context,
                          initialTime: timeCubit.state.time,
                        ).then((value) => timeCubit.changeTime(value));
                      },
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    const Text(
                      'Kategori:',
                      style: TextStyle(
                        fontFamily: 'Patrick Hand',
                        fontSize: 18,
                        color: Color(0xFF309CFF),
                      ),
                    ),
                    DropdownButton(
                      items: dropdownMenuBuilder(dropdownMenus),
                      onChanged: (value) {},
                      isExpanded: true,
                      value: 'Semua',
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    Align(
                      alignment: Alignment.center,
                      child: Container(
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
                            widget.isAdd ? 'Tambah' : 'Edit',
                            style: const TextStyle(
                              fontFamily: 'Patrick Hand',
                              fontSize: 22,
                              color: Colors.white,
                            ),
                          ),
                          onPressed: () {
                            formKey.currentState!.validate();
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
}
