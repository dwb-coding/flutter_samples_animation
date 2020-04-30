import 'package:animations/application/ui/pages/animations_page.dart';
import 'package:flutter/material.dart';

void main() => runApp(AnimationsApp());

class AnimationsApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Animations Demo',
      theme: ThemeData(
        primarySwatch: Colors.orange,
      ),
      home: AnimationsPage(),
    );
  }
}

