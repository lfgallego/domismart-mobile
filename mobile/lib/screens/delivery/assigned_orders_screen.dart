import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../services/order_service.dart';
import '../../models/order_model.dart';

class AssignedOrdersScreen extends StatelessWidget {
  const AssignedOrdersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final deliveryId = FirebaseAuth.instance.currentUser?.uid ?? '';
    final OrderService orderService = OrderService();

    return Scaffold(
      appBar: AppBar(title: const Text('Mis Entregas')),
      body: StreamBuilder<List<OrderModel>>(
        stream: orderService.getOrdersByDelivery(deliveryId),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          final orders = snapshot.data ?? [];
          return ListView.builder(
            itemCount: orders.length,
            itemBuilder: (context, index) {
              final order = orders[index];
              return Card(
                child: ListTile(
                  title: Text('Entrega a: ${order.direccionEntrega}'),
                  subtitle: Text('Estado: ${order.estado}'),
                  trailing: ElevatedButton(
                    onPressed: () {
                      if (order.estado == 'en_camino') {
                        orderService.updateOrderStatus(order.id, 'entregado');
                      }
                    },
                    child: const Text('Marcar Entregado'),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}