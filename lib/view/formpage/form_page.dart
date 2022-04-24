import 'package:flutter/material.dart';
import 'package:todo_app/view/formpage/activity_description_form.dart';

class FormPage extends StatefulWidget {
  final bool isAdd;
  final String? activity;
  final String? description;
  final String? date;
  final int? hour;
  final int? minute;
  final String? category;

  const FormPage({
    Key? key,
    required this.isAdd,
    this.activity,
    this.description,
    this.date,
    this.hour,
    this.minute,
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
      body: Form(
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
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
