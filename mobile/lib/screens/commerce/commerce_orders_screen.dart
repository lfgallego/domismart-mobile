import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../services/order_service.dart';
import '../../models/order_model.dart';

class CommerceOrdersScreen extends StatelessWidget {
  const CommerceOrdersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final commerceId = FirebaseAuth.instance.currentUser?.uid ?? '';
    final OrderService orderService = OrderService();

    return Scaffold(
      appBar: AppBar(title: const Text('Pedidos del Comercio')),
      body: StreamBuilder<List<OrderModel>>(
        stream: orderService.getOrdersByCommerce(commerceId),
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
                  title: Text('Cliente: ${order.clienteNombre}'),
                  subtitle: Text('Estado: ${order.estado}'),
                  trailing: ElevatedButton(
                    onPressed: () {
                      if (order.estado == 'pendiente') {
                        orderService.updateOrderStatus(order.id, 'aceptado');
                      } else if (order.estado == 'aceptado') {
                        orderService.updateOrderStatus(order.id, 'preparando');
                      } else if (order.estado == 'preparando') {
                        orderService.updateOrderStatus(order.id, 'listo');
                      }
                    },
                    child: const Text('Avanzar Estado'),
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