import 'package:flutter/material.dart';
import 'src/home_screen.dart';

void main() {
  runApp(MaterialApp(
      theme: ThemeData(
          brightness: Brightness.dark,
          primaryColor: Colors.white,
          textButtonTheme: const TextButtonThemeData(
              style: ButtonStyle(
                  backgroundColor:
                      MaterialStatePropertyAll(Color(0xff202020))))),
      home: const HomeScreen()));
}
