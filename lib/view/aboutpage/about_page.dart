import 'package:flutter/material.dart';
import 'package:todo_app/blocs/darktheme_cubit/darktheme_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(
                height: 50,
              ),
              Image.asset(
                'assets/images/todoapp.png',
                height: 60,
              ),
              const SizedBox(
                height: 20,
              ),
              Builder(builder: (context) {
                final DarkthemeChanged darkthemeState =
                    context.watch<DarkthemeCubit>().state as DarkthemeChanged;
                return Container(
                  padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
                  child: Text(
                    '''
      TodoApp adalah aplikasi sederhana untuk mencatat rencana - rencana kegiatan anda sehari - hari.
      
      Rencana - rencana yang telah diinputkan akan langsung diurutkan di halaman utama berdasarkan waktu pelaksanaanya. Sehingga memudahkan anda dalam mengecek jadwalnya.
      
      Data - data rencana disimpan di local memory / di dalam device anda. Sehingga tidak membutuhkan jaringan internet untuk menggunakan aplikasi ini.
                    ''',
                    style: TextStyle(
                      fontFamily: 'Patrick Hand',
                      fontSize: 18,
                      color:
                          darkthemeState.isDark ? Colors.white : Colors.black54,
                    ),
                    textAlign: TextAlign.justify,
                  ),
                );
              })
            ],
          ),
        ),
      ),
    );
  }
}
