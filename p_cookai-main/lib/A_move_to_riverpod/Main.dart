import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'features/menu/screens/menu_screen.dart';

void main() {
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Mi App con Riverpod',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MenuScreen(), // Aquí cargas el nuevo menú
    );
  }
}
