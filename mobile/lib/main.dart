import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'screens/login_screen.dart';

void main() async {
  // Asegura que los bindings de Flutter estén listos antes de inicializar Firebase
  WidgetsFlutterBinding.ensureInitialized();
  
  // Inicializa Firebase con las opciones de tu proyecto 'domismart'
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

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
      home: const LoginScreen(),
    );
  }
}