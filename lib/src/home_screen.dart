import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'dart:async';
import 'menu_page.dart';
import 'favorites_page.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color(0xff101010),
        body: PageView(
            controller: PageController(initialPage: 1),
            children: const [FavoritesPage(), HomePage(), MenuPage()]));
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
      const Clock(),
      Text("REIMCH", style: GoogleFonts.notoSans(fontSize: 50)),
      const SizedBox()
    ]);
  }
}

class Clock extends StatefulWidget {
  const Clock({super.key});

  @override
  State<Clock> createState() => _ClockState();
}

class _ClockState extends State<Clock> {
  String time = DateFormat('hh.mm a').format(DateTime.now());
  late Timer _timer;

  @override
  initState() {
    super.initState();
    _timer =
        Timer.periodic(const Duration(milliseconds: 500), (timer) => _update());
  }

  void _update() {
    time = DateFormat('hh.mm a').format(DateTime.now());
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Text(time, style: GoogleFonts.barlow(fontSize: 30));
  }
}
