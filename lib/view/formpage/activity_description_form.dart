import 'package:flutter/material.dart';

class ActivityDescriptionForm extends StatelessWidget {
  final TextEditingController controller;
  final String title;
  final String? Function(String?)? validation;
  final bool isDark;

  const ActivityDescriptionForm({
    Key? key,
    required this.isDark,
    required this.controller,
    required this.title,
    this.validation,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: InputDecoration(
        labelText: title,
        labelStyle: const TextStyle(
          fontFamily: 'Patrick Hand',
          fontSize: 18,
          color: Color(0xFF309CFF),
        ),
        errorStyle: const TextStyle(
            fontSize: 18, color: Colors.red, fontFamily: 'Patrick Hand'),
      ),
      style: TextStyle(
        fontSize: 16,
        fontFamily: 'Patrick Hand',
        color: isDark ? Colors.white : Colors.black54,
      ),
      controller: controller,
      validator: validation,
    );
  }
}
