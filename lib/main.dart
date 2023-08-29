import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'src/home_screen.dart';

void main() {
  runApp(MaterialApp(
      theme: ThemeData(
        brightness: Brightness.dark,
        primaryColor: Colors.white,
        textTheme: TextTheme(
            bodySmall: GoogleFonts.openSans() // textStyle for icons
                .copyWith(
                    color: Colors.white,
                    fontSize: 13,
                    fontWeight: FontWeight.bold)),
      ),
      home: HomePage()));
}
