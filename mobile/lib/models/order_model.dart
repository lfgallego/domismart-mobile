import 'package:cloud_firestore/cloud_firestore.dart';

class OrderModel {
  final String id;
  final String clienteId;
  final String clienteNombre;
  final String comercioId;
  final String comercioNombre;
  final String? domiciliarioId;
  final List<Map<String, dynamic>> productos;
  final double total;
  final String direccionEntrega;
  final String estado;
  final DateTime fechaCreacion;

  OrderModel({
    required this.id,
    required this.clienteId,
    required this.clienteNombre,
    required this.comercioId,
    required this.comercioNombre,
    this.domiciliarioId,
    required this.productos,
    required this.total,
    required this.direccionEntrega,
    required this.estado,
    required this.fechaCreacion,
  });

  factory OrderModel.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return OrderModel(
      id: doc.id,
      clienteId: data['clienteId'] ?? '',
      clienteNombre: data['clienteNombre'] ?? '',
      comercioId: data['comercioId'] ?? '',
      comercioNombre: data['comercioNombre'] ?? '',
      domiciliarioId: data['domiciliarioId'],
      productos: List<Map<String, dynamic>>.from(data['productos'] ?? []),
      total: (data['total'] ?? 0.0).toDouble(),
      direccionEntrega: data['direccionEntrega'] ?? '',
      estado: data['estado'] ?? 'pendiente',
      fechaCreacion: (data['fechaCreacion'] as Timestamp).toDate(),
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      'clienteId': clienteId,
      'clienteNombre': clienteNombre,
      'comercioId': comercioId,
      'comercioNombre': comercioNombre,
      'domiciliarioId': domiciliarioId,
      'productos': productos,
      'total': total,
      'direccionEntrega': direccionEntrega,
      'estado': estado,
      'fechaCreacion': Timestamp.fromDate(fechaCreacion),
    };
  }
}