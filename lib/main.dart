import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:device_apps/device_apps.dart' show Application;
import 'package:provider/provider.dart';
import 'src/menu_screen.dart';
import 'src/data.dart';

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
      home: App()));
}

class App extends StatelessWidget {
  Data data = Data();

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<Data>(
        create: (context) => data, child: const MenuScreen());
  }
}
