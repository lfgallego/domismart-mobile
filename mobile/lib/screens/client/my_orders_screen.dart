import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../services/order_service.dart';
import '../../models/order_model.dart';

class MyOrdersScreen extends StatelessWidget {
  const MyOrdersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final userId = FirebaseAuth.instance.currentUser?.uid ?? '';
    final OrderService orderService = OrderService();

    return Scaffold(
      appBar: AppBar(title: const Text('Mis Pedidos')),
      body: StreamBuilder<List<OrderModel>>(
        stream: orderService.getOrdersByClient(userId),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          final orders = snapshot.data ?? [];
          if (orders.isEmpty) {
            return const Center(child: Text('No tienes pedidos activos'));
          }
          return ListView.builder(
            itemCount: orders.length, 
            itemBuilder: (context, index) {
              final order = orders[index];
              return ListTile(
                title: Text('Pedido a ${order.comercioNombre}'),
                subtitle: Text('Estado: ${order.estado.toUpperCase()}'),
                trailing: Text('\$${order.total.toStringAsFixed(2)}'),
              );
            },
          );
        },
      ),
    );
  }
}