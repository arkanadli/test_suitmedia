import 'package:flutter/material.dart';
import 'package:test_suitmedia/views/first_screen.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        fontFamily: 'Poppins',
      ),
      home: const Scaffold(
        body: Center(
          child: FirstScreen(),
        ),
      ),
    );
  }
}
