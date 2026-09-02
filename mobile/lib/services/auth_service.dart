import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  // Obtener usuario actual
  User? get currentUser => _auth.currentUser;

  // Registro de usuario + Guardar datos en Firestore
  Future<UserCredential?> signUp({
    required String email,
    required String password,
    required String name,
    required String role, // 'cliente', 'domiciliario', 'comercio'
  }) async {
    try {
      UserCredential res = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      if (res.user != null) {
        // Guardar información del usuario en la colección 'users'
        await _db.collection('users').doc(res.user!.uid).set({
          'uid': res.user!.uid,
          'name': name,
          'email': email,
          'role': role,
          'createdAt': FieldValue.serverTimestamp(),
        });
      }
      return res;
    } catch (e) {
      rethrow;
    }
  }

  // Iniciar sesión
  Future<UserCredential?> signIn({
    required String email,
    required String password,
  }) async {
    try {
      return await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
    } catch (e) {
      rethrow;
    }
  }

  // Cerrar sesión
  Future<void> signOut() async {
    await _auth.signOut();
  }
}