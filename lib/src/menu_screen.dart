import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'app_data.dart';
import 'application_card.dart';

class MenuScreen extends StatefulWidget {
  const MenuScreen({super.key});

  @override
  State<MenuScreen> createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> {
  @override
  Widget build(BuildContext context) {
    var apps = context.watch<AppData>().apps;
    return PageView(children: [
      Scaffold(
          backgroundColor: Colors.black,
          body: apps.isNotEmpty
              ? GridView(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3),
                  children: List.generate(
                      apps.length,
                      (index) => ApplicationCard(apps[index])))
              : const Center(child: CircularProgressIndicator()))
    ]);
  }
}
