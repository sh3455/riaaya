import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:riaaya_app/features/request_status/data/model/request_model.dart';

class ClientRequestsRepo {
  final FirebaseFirestore firestore;
  ClientRequestsRepo(this.firestore);

  /// 🔹 يجيب طلبات العميل الحالي
  Future<List<RequestModel>> getMyRequests() async {
    final uid = FirebaseAuth.instance.currentUser?.uid;
    if (uid == null) return [];

    final snap = await firestore
        .collection('requests')
        .where('clientId', isEqualTo: uid)
        .get();

    final list = snap.docs
        .map((doc) => RequestModel.fromMap(doc.id, doc.data()))
        .toList();

    // ترتيب محلي (الأحدث الأول)
    list.sort((a, b) => b.date.compareTo(a.date));

    return list;
  }
}
