import 'package:flutter/material.dart';

final ThemeData darkTheme = ThemeData(
  primaryColor: const Color.fromARGB(255, 248, 248, 248), //judul
  fontFamily: 'Lato',

  brightness: Brightness.dark,
  scaffoldBackgroundColor: Color.fromARGB(255, 82, 82, 82), //container awl msuk/dftr, dn background pages lain
  appBarTheme: const AppBarTheme(
    backgroundColor: Color(0xFF21262B),
    // backgroundColor:  Color.fromARGB(136, 0, 0, 0), //background awl msuk/dftr
    iconTheme: IconThemeData(color: Color.fromARGB(255, 213, 218, 224)), //icon
  ),
  floatingActionButtonTheme: const FloatingActionButtonThemeData(
    backgroundColor: Color(0xFF303239), //button dpn masuk/daftar &label atas
  ),
  textTheme: const TextTheme(
    bodyText1: TextStyle(
        color: Color.fromARGB(255, 233, 236, 240),
        fontFamily: 'Itim'), //text deskripsi
  ),
  backgroundColor: const Color.fromARGB(255, 37, 42, 51), //navigasi bwh
);
