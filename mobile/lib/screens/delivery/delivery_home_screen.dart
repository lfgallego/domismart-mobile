import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../services/order_service.dart';
import '../../models/order_model.dart';
import 'assigned_orders_screen.dart';

class DeliveryHomeScreen extends StatelessWidget {
  const DeliveryHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final deliveryId = FirebaseAuth.instance.currentUser?.uid ?? '';
    final OrderService orderService = OrderService();

    return Scaffold(
      appBar: AppBar(
        title: const Text('DomiSmart - Domiciliario'),
        backgroundColor: Colors.deepOrange,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Card(
              color: Colors.green.shade50,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
                side: BorderSide(color: Colors.green.shade200),
              ),
              child: const Padding(
                padding: EdgeInsets.all(16.0),
                child: Row(
                  children: [
                    Icon(Icons.two_wheeler, size: 40, color: Colors.green),
                    SizedBox(width: 12),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Estado: Activo', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                        Text('Listo para recibir entregas'),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
            StreamBuilder<List<OrderModel>>(
              stream: orderService.getOrdersByDelivery(deliveryId),
              builder: (context, snapshot) {
                final orders = snapshot.data ?? [];
                final enCamino = orders.where((o) => o.estado == 'en_camino').length;

                return Card(
                  child: ListTile(
                    leading: const Icon(Icons.local_shipping, color: Colors.deepOrange),
                    title: Text('Entregas en curso: $enCamino'),
                    subtitle: const Text('Haz clic para revisar tu ruta'),
                    trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => const AssignedOrdersScreen()),
                      );
                    },
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}