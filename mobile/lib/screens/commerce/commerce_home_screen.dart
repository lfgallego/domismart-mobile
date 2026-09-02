import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../services/order_service.dart';
import '../../models/order_model.dart';
import 'commerce_orders_screen.dart';

class CommerceHomeScreen extends StatelessWidget {
  const CommerceHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final commerceId = FirebaseAuth.instance.currentUser?.uid ?? '';
    final OrderService orderService = OrderService();

    return Scaffold(
      appBar: AppBar(
        title: const Text('DomiSmart - Comercio'),
        backgroundColor: Colors.deepOrange,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Resumen Métricas
            StreamBuilder<List<OrderModel>>(
              stream: orderService.getOrdersByCommerce(commerceId),
              builder: (context, snapshot) {
                final orders = snapshot.data ?? [];
                final pendientes = orders.where((o) => o.estado == 'pendiente').length;

                return Row(
                  children: [
                    Expanded(
                      child: Card(
                        color: Colors.orange.shade100,
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            children: [
                              Text('$pendientes', style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                              const Text('Pendientes'),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Card(
                        color: Colors.blue.shade100,
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            children: [
                              Text('${orders.length}', style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                              const Text('Total Pedidos'),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                );
              },
            ),
            const SizedBox(height: 20),

            // Acceso a Gestión
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const CommerceOrdersScreen()),
                  );
                },
                icon: const Icon(Icons.store),
                label: const Text('Gestionar Todos los Pedidos'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.deepOrange,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}