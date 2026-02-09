import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:riaaya_app/features/request_status/data/model/request_model.dart';

class ClientRequestsRepo {
  final FirebaseFirestore firestore;
  ClientRequestsRepo(this.firestore);

  Future<List<RequestModel>> getMyRequests() async {
    final uid = FirebaseAuth.instance.currentUser!.uid;

    final snap = await firestore
        .collection('requests')
        .where('clientId', isEqualTo: uid)
        .get();

    return snap.docs
        .map((d) => RequestModel.fromMap(d.id, d.data()))
        .toList();
  }
}
