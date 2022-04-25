import 'package:flutter/material.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: SafeArea(
        child: Container(
          width: MediaQuery.of(context).size.width * 0.7,
          child: Column(
            children: [
              Image.asset('assets/images/logo.png'),
              const SizedBox(
                height: 30,
              ),
              TextButton(
                child: const Text(
                  'Tentang Aplikasi',
                  style: TextStyle(
                    fontSize: 18,
                    fontFamily: 'Patrick Hand',
                    color: Color(0xFF309CFF),
                  ),
                ),
                onPressed: () {},
              ),
              const SizedBox(
                width: 150,
                child: Divider(
                  thickness: 3,
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.flare),
                  Switch(
                    value: false,
                    onChanged: (value) {},
                  ),
                  const Icon(Icons.nightlight_round),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
