import 'package:flutter/material.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Image.asset(
                'assets/images/logo.png',
                width: 330,
                height: 250,
              ),
              const SizedBox(
                height: 20,
              ),
              Image.asset(
                'assets/images/todoapp.png',
                width: 105,
                height: 47,
              ),
              const SizedBox(
                height: 8,
              ),
              Container(
                padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
                child: const Text(
                  '''
      TodoApp adalah aplikasi sederhana untuk mencatat rencana - rencana kegiatan anda sehari - hari.
      
      Rencana - rencana yang telah diinputkan akan langsung diurutkan di halaman utama berdasarkan waktu pelaksanaanya. Sehingga memudahkan anda dalam mengecek jadwalnya.
      
      Data - data rencana disimpan di local memory / di dalam device anda. Sehingga tidak membutuhkan jaringan internet untuk menggunakan aplikasi ini.
      
      Rencana yang telah kadaluwarsa akan otomatis dihapus, sehingga akan lebih menghemat memori.
                ''',
                  style: TextStyle(
                    fontFamily: 'Patrick Hand',
                    fontSize: 18,
                    color: Colors.black54,
                  ),
                  textAlign: TextAlign.justify,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
