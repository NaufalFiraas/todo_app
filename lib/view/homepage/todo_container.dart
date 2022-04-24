import 'package:flutter/material.dart';

class TodoContainer extends StatelessWidget {
  final String dayTitle;
  final String title;
  final String description;
  final String category;
  final String date;
  final int hour;
  final int minute;

  const TodoContainer({
    Key? key,
    required this.dayTitle,
    required this.title,
    required this.description,
    required this.date,
    required this.hour,
    required this.minute,
    required this.category,
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
                  topLeft: Radius.circular(15),
                  topRight: Radius.circular(15),
                ),
              ),
              child: Text(
                dayTitle,
                style: const TextStyle(
                  fontFamily: 'Patrick Hand',
                  fontSize: 18,
                  fontWeight: FontWeight.w400,
                  color: Colors.white,
                ),
              ),
            ),
            ListTile(
              leading: Checkbox(
                shape: const StadiumBorder(),
                activeColor: Colors.amber,
                value: true,
                onChanged: (value) {},
              ),
              title: Text(
                title,
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
                    description,
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
                    date,
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
                    hour.toString().padLeft(2, '0') +
                        ' : ' +
                        minute.toString().padLeft(2, '0'),
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
                    category,
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
