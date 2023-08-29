import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:device_apps/device_apps.dart';
import 'menu_screen.dart';
import 'application_card.dart';
import 'data.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  @override
  Widget build(BuildContext context) {
    var data = context.watch<Data>();
    return Scaffold(
        body: data.initialized
            ? Column(children: [
                GridView(
                    gridDelegate: const SilverGridDelegateWithMaxCrossAxisCount(
                        crossAxis: 3),
                    children: List.generate(
                        data.favorites.length,
                        (index) => ApplicationCard(
                            data.apps.where((Application app) =>
                                app.packageName == data.favorites[index]),
                            favorite: true))),
                Center(
                    child: ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  (context) => const MenuScreen()));
                        },
                        child: const Icon(Icons.menu)))
              ])
            : const Center(child: CircularProgressIndicator()));
  }
}
