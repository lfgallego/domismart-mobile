import 'package:flutter/material.dart';
import 'screens/login_screen.dart';

void main() {
  runApp(const DomiSmartApp());
}

class DomiSmartApp extends StatelessWidget {
  const DomiSmartApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'DomiSmart',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepOrange),
        useMaterial3: true,
      ),
      home: const LoginScreen(), // Aquí conectamos la nueva pantalla
    );
  }
}