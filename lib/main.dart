import 'package:flutter/material.dart';
import 'screens/loading_screen.dart';

void main() => runApp(Corona());

class Corona extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: LoadingScreen(),
    );
  }
}
