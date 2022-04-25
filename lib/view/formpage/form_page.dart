import 'package:flutter/material.dart';
import 'package:todo_app/view/formpage/activity_description_form.dart';
import 'package:intl/intl.dart';

class FormPage extends StatefulWidget {
  final bool isAdd;
  final String? activity;
  final String? description;
  final DateTime? date;
  final TimeOfDay? time;
  final String? category;

  const FormPage({
    Key? key,
    required this.isAdd,
    this.activity,
    this.description,
    this.date,
    this.time,
    this.category,
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
    if (!widget.isAdd) {
      activityController.text = widget.activity.toString();
      descriptionController.text = widget.description.toString();
    }
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
                        widget.date == null
                            ? 'Tap di sini...'
                            : DateFormat('dd/MMM/yyyy').format(widget.date!),
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
                          initialDate:
                              widget.isAdd ? DateTime.now() : widget.date!,
                          lastDate:
                              DateTime.now().add(const Duration(days: 365)),
                        ).then((value) => null);
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
                        widget.time == null
                            ? 'Tap di sini...'
                            : widget.time!.hour.toString().padLeft(2, '0') +
                                ' : ' +
                                widget.time!.minute.toString().padLeft(2, '0'),
                        style: const TextStyle(
                          fontFamily: 'Patrick Hand',
                          fontSize: 16,
                          color: Colors.black54,
                        ),
                      ),
                      onTap: () {
                        showTimePicker(
                          context: context,
                          initialTime: widget.time == null
                              ? TimeOfDay.now()
                              : widget.time!,
                        ).then((value) => null);
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
