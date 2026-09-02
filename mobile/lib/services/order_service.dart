import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/order_model.dart';

class OrderService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  // Crear un nuevo pedido
  Future<void> createOrder(OrderModel order) async {
    await _db.collection('orders').add(order.toFirestore());
  }

  // Actualizar estado del pedido
  Future<void> updateOrderStatus(String orderId, String newStatus) async {
    await _db.collection('orders').doc(orderId).update({
      'estado': newStatus,
    });
  }

  // Asignar domiciliario a un pedido
  Future<void> assignDeliveryPerson(String orderId, String domiciliarioId) async {
    await _db.collection('orders').doc(orderId).update({
      'domiciliarioId': domiciliarioId,
      'estado': 'en_camino',
    });
  }

  // Flujos de lectura en tiempo real (Streams)
  Stream<List<OrderModel>> getOrdersByClient(String clienteId) {
    return _db
        .collection('orders')
        .where('clienteId', isEqualTo: clienteId)
        .orderBy('fechaCreacion', descending: true)
        .snapshots()
        .map((snap) => snap.docs.map((doc) => OrderModel.fromFirestore(doc)).toList());
  }

  Stream<List<OrderModel>> getOrdersByCommerce(String comercioId) {
    return _db
        .collection('orders')
        .where('comercioId', isEqualTo: comercioId)
        .orderBy('fechaCreacion', descending: true)
        .snapshots()
        .map((snap) => snap.docs.map((doc) => OrderModel.fromFirestore(doc)).toList());
  }

  Stream<List<OrderModel>> getOrdersByDelivery(String domiciliarioId) {
    return _db
        .collection('orders')
        .where('domiciliarioId', isEqualTo: domiciliarioId)
        .orderBy('fechaCreacion', descending: true)
        .snapshots()
        .map((snap) => snap.docs.map((doc) => OrderModel.fromFirestore(doc)).toList());
  }
}