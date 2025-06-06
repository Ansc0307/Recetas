
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../A_move_to_riverpod/features/diabetes/screens/diabetes_form_screen.dart';

void main() {
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Predicción de Diabetes',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const DiabetesFormScreen(),
    );
  }
}
