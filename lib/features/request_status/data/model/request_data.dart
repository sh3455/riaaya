import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'request_model.dart';

class RequestData {
  // ✅ Stream: يسمع طلبات العميل الحالي فقط (بدون index)
  static Stream<List<RequestModel>> requestsStream() {
    final uid = FirebaseAuth.instance.currentUser?.uid;

    if (uid == null) {
      return const Stream.empty();
    }

    return FirebaseFirestore.instance
        .collection('requests')
        .where('clientId', isEqualTo: uid) // ✅ فلترة
        .snapshots()
        .map((snap) {
      final list = snap.docs
          .map((doc) => RequestModel.fromMap(doc.id, doc.data()))
          .toList();

      // ✅ ترتيب محلي بدل orderBy (عشان مانحتاجش index)
      list.sort((a, b) {
        final aDate = a.date;
        final bDate = b.date;
        return bDate.compareTo(aDate); // الأحدث الأول
      });

      return list;
    });
  }

  // ✅ Future: تحميل مرة واحدة (بدون index)
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

    list.sort((a, b) => b.date.compareTo(a.date));

    return list;
  }
}
