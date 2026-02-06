import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseService {
  final FirebaseAuth _auth;
  final FirebaseFirestore _firestore;

  FirebaseService({
    FirebaseAuth? auth,
    FirebaseFirestore? firestore,
  })  : _auth = auth ?? FirebaseAuth.instance,
        _firestore = firestore ?? FirebaseFirestore.instance;

  Future<UserCredential> createUser({
    required String role,
    required String name,
    String? birth,
    String? phone,
    String? location,
    String? experience,
    required String email,
    required String password,
  }) async {
    final credential = await _auth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );

    final data = {
      'uid': credential.user!.uid,
      'name': name,
      'email': email,
      'role': role,
      'createdAt': FieldValue.serverTimestamp(),
    };

    if (birth != null) data['birth'] = birth;
    if (phone != null) data['phone'] = phone;
    if (location != null) data['location'] = location;
    if (experience != null) data['experience'] = experience;

    final collectionName = role == 'nurse' ? 'nurses' : 'clients';
    await _firestore.collection(collectionName).doc(credential.user!.uid).set(data);

    return credential;
  }

  Future<UserCredential> login({
    required String email,
    required String password,
  }) async {
    return await _auth.signInWithEmailAndPassword(email: email, password: password);
  }

  Future<void> signOut() async {
    await _auth.signOut();
  }
}
