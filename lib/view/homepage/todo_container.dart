import 'package:flutter/material.dart';
import 'package:todo_app/data/models/todo.dart';
import 'package:todo_app/view/formpage/form_page.dart';
import 'package:intl/intl.dart';

class TodoContainer extends StatelessWidget {
  final Todo todo;

  const TodoContainer({
    Key? key,
    required this.todo,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: UniqueKey(),
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
              content: const Text(
                'Yakin Hapus?',
                style: TextStyle(
                  fontFamily: 'Patrick Hand',
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                  color: Colors.black54,
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
                  onPressed: () {},
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
          color: Colors.white,
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
                      return const FormPage(isAdd: false);
                    },
                  ),
                );
              },
              leading: Checkbox(
                shape: const StadiumBorder(),
                activeColor: Colors.amber,
                value: true,
                onChanged: (value) {},
              ),
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
    );
  }
}
