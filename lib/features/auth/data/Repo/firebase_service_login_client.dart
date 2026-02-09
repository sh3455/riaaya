import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'hive_auth_service.dart';

class FirebaseServiceLoginClient {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final HiveAuthService _hive = HiveAuthService();

  Future<String?> loginClient({required String email, required String password}) async {
    try {
      final userCredential = await _auth.signInWithEmailAndPassword(
        email: email.trim(),
        password: password.trim(),
      );

      final uid = userCredential.user!.uid;
      final doc = await _firestore.collection('clients').doc(uid).get();

      if (!doc.exists) {
        await _auth.signOut();
        return "User not found in database";
      }

      // حفظ login في Hive
      await _hive.saveLogin(userType: 'client', uid: uid);
      return null;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') return 'No user found for that email.';
      if (e.code == 'wrong-password') return 'Wrong password provided.';
      return 'Auth Error: ${e.code}';
    } catch (e) {
      return 'Error: $e';
    }
  }

  Future<void> logout() async {
    await _auth.signOut();
    await _hive.clearLogin();
  }
}
