import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:riaaya_app/features/profile/presentation/view_model/cubit/client_profile.dart';

class ClientProfileRepository {
  final FirebaseFirestore firestore;
  ClientProfileRepository(this.firestore);

  Stream<ClientProfile> watchClient(String uid) {
    return firestore.collection('clients').doc(uid).snapshots().map((doc) {
      final data = doc.data() ?? {};
      return ClientProfile.fromMap(data);
    });
  }

  Future<void> updateClient(String uid, Map<String, dynamic> updates) {
    return firestore.collection('clients').doc(uid).update(updates);
  }
}
