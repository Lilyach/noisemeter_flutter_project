import 'package:flutter/material.dart';
import 'package:noisemeter_project/bottom_bar/bottom_bar.dart';
import 'package:noisemeter_project/services/info_to_screens.dart';

class Saves extends StatelessWidget {
  final InfoToScreens infoToScreens;
  const Saves(this.infoToScreens, {super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:  const SafeArea(
        child: Text('Сохраненные'),
      ),
      bottomNavigationBar: BottomBar(infoToScreens),
    );
  }
}
