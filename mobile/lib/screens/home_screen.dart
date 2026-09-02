import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../services/auth_service.dart';
import 'login_screen.dart';

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

    return Scaffold(
      appBar: AppBar(
        title: const Text('DomiSmart Dashboard'),
        backgroundColor: Colors.deepOrange,
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: _handleSignOut,
            tooltip: 'Cerrar Sesión',
          ),
        ],
      ),
      body: user == null
          ? const Center(child: Text('No hay usuario activo'))
          : FutureBuilder<DocumentSnapshot>(
              future: _db.collection('users').doc(user.uid).get(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(color: Colors.deepOrange),
                  );
                }

                if (snapshot.hasError) {
                  return Center(
                    child: Text('Error al cargar datos: ${snapshot.error}'),
                  );
                }

                if (!snapshot.hasData || !snapshot.data!.exists) {
                  return const Center(
                    child: Text('Datos del usuario no encontrados'),
                  );
                }

                final userData = snapshot.data!.data() as Map<String, dynamic>;
                final name = userData['name'] ?? 'Usuario';
                final role = userData['role'] ?? 'cliente';

                return Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Card(
                        elevation: 4,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Row(
                            children: [
                              CircleAvatar(
                                radius: 30,
                                backgroundColor: Colors.deepOrange.shade100,
                                child: const Icon(
                                  Icons.person,
                                  size: 36,
                                  color: Colors.deepOrange,
                                ),
                              ),
                              const SizedBox(width: 16),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      '¡Hola, $name!',
                                      style: const TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    const SizedBox(height: 4),
                                    Chip(
                                      label: Text(
                                        role.toUpperCase(),
                                        style: const TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 12,
                                        ),
                                      ),
                                      backgroundColor: Colors.deepOrange,
                                      padding: EdgeInsets.zero,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 32),
                      const Text(
                        'Acciones Rápidas',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 16),
                      ListTile(
                        leading: const Icon(Icons.shopping_bag_outlined,
                            color: Colors.deepOrange),
                        title: const Text('Mis Pedidos'),
                        trailing: const Icon(Icons.chevron_right),
                        onTap: () {},
                      ),
                      const Divider(),
                      ListTile(
                        leading: const Icon(Icons.settings_outlined,
                            color: Colors.deepOrange),
                        title: const Text('Configuración del Perfil'),
                        trailing: const Icon(Icons.chevron_right),
                        onTap: () {},
                      ),
                    ],
                  ),
                );
              },
            ),
    );
  }
}