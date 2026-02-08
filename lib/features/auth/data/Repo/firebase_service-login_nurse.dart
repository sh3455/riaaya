import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class NurseAuthRepository {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<User?> login({required String email, required String password}) async {
    final userCredential = await _auth.signInWithEmailAndPassword(
      email: email.trim(),
      password: password.trim(),
    );

    final uid = userCredential.user!.uid;

    final nurseDoc = await _firestore.collection('nurses').doc(uid).get();

    if (!nurseDoc.exists) {
      await _auth.signOut();
      throw Exception("This account is not registered as a nurse");
    }

    return userCredential.user;
  }
}
