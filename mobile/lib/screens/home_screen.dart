import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../services/auth_service.dart';
import 'login_screen.dart';
import 'client/client_home_screen.dart';
import 'commerce/commerce_home_screen.dart';
import 'delivery/delivery_home_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final AuthService _authService = AuthService();
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  void _handleSignOut() async {
    await _authService.signOut();
    if (mounted) {
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => const LoginScreen()),
        (route) => false,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final user = _authService.currentUser;

    if (user == null) {
      return const Scaffold(
        body: Center(child: Text('No hay usuario activo')),
      );
    }

    return FutureBuilder<DocumentSnapshot>(
      future: _db.collection('users').doc(user.uid).get(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
            body: Center(
              child: CircularProgressIndicator(color: Colors.deepOrange),
            ),
          );
        }

        if (snapshot.hasError || !snapshot.hasData || !snapshot.data!.exists) {
          return Scaffold(
            appBar: AppBar(
              title: const Text('DomiSmart'),
              backgroundColor: Colors.deepOrange,
              actions: [
                IconButton(
                  icon: const Icon(Icons.logout),
                  onPressed: _handleSignOut,
                ),
              ],
            ),
            body: const Center(
              child: Text('Error al cargar la información del usuario'),
            ),
          );
        }

        final userData = snapshot.data!.data() as Map<String, dynamic>;
        final role = (userData['role'] ?? 'cliente').toString().toLowerCase();

        // Enrutamiento según el rol del usuario guardado en Firestore
        if (role == 'comercio') {
          return const CommerceHomeScreen();
        } else if (role == 'domiciliario') {
          return const DeliveryHomeScreen();
        } else {
          return const ClientHomeScreen();
        }
      },
    );
  }
}