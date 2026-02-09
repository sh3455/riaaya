import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'request_model.dart';

class RequestData {

  /// 🔹 تحميل مرة واحدة (أفضل ليك)
  static Future<List<RequestModel>> getRequestsOnce() async {
    final uid = FirebaseAuth.instance.currentUser?.uid;

    if (uid == null) return [];

    final snap = await FirebaseFirestore.instance
        .collection('requests')
        .where('clientId', isEqualTo: uid)
        .get();

    final list = snap.docs
        .map((doc) => RequestModel.fromMap(doc.id, doc.data()))
        .toList();

    // ترتيب: الأحدث الأول
    list.sort((a, b) => b.date.compareTo(a.date));

    return list;
  }

  /// 🔹 لو حبيت Stream في المستقبل
  static Stream<List<RequestModel>> requestsStream() {
    final uid = FirebaseAuth.instance.currentUser?.uid;

    if (uid == null) return const Stream.empty();

    return FirebaseFirestore.instance
        .collection('requests')
        .where('clientId', isEqualTo: uid)
        .snapshots()
        .map((snap) {
      final list = snap.docs
          .map((doc) => RequestModel.fromMap(doc.id, doc.data()))
          .toList();

      list.sort((a, b) => b.date.compareTo(a.date));

      return list;
    });
  }
}
