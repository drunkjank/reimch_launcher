import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';
import 'menu_screen.dart';
import 'app_data.dart';

class HomePage extends StatelessWidget {
  final AppData appData = AppData();

  HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(children: [
        Center(child: Text('REIMCH', style: GoogleFonts.rubikIso().copyWith(fontSize: 50, fontWeight: FontWeight.bold), textAlign: TextAlign.center)),
        ChangeNotifierProvider<AppData>(
          create: (context) => appData,
          child: const MenuScreen()
        ),
      ])
    );
  }
}
