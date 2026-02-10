import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:riaaya_app/features/request_status/data/model/request_model.dart';


class NurseRequestsRepo {
  final FirebaseFirestore firestore;
  final FirebaseAuth auth;

  NurseRequestsRepo({
    required this.firestore,
    required this.auth,
  });

  Future<List<RequestModel>> getAvailableRequests() async {
    // بدون index: هنجيب pending بس (ده غالبًا مش محتاج index)
    final snap = await firestore
        .collection('requests')
        .where('status', isEqualTo: 'pending')
        .get();

    // فلترة محلية: نخليها اللي nurseId فاضي/ null
    final docs = snap.docs.where((d) {
      final data = d.data();
      final nurseId = data['nurseId'];
      return nurseId == null || nurseId.toString().trim().isEmpty;
    }).toList();

    // ترتيب محلي بالأحدث (لو عندك createdAt أو date String)
    // هنرتّب بالـ doc.id أو date كسلسلة (مش مثالي بس يمشي)
    docs.sort((a, b) {
      final ad = a.data()['date'];
      final bd = b.data()['date'];
      final aS = (ad ?? '').toString();
      final bS = (bd ?? '').toString();
      return bS.compareTo(aS);
    });

    return docs.map((doc) => RequestModel.fromMap(doc.id, doc.data())).toList();
  }

  Future<void> acceptRequest(String requestId) async {
    final nurseUid = auth.currentUser?.uid;
    if (nurseUid == null) throw Exception("Nurse not logged in");

    await firestore.collection('requests').doc(requestId).update({
      'status': 'accepted',
      'nurseId': nurseUid,
      'acceptedAt': FieldValue.serverTimestamp(),
    });
  }

  Future<void> declineRequest(String requestId) async {
    // انت ممكن تعمل decline يعني تسيبها pending وتخلي nurseId فاضي
    // أو تعمل status = pending و nurseId = null (زي ما انت عايز)
    await firestore.collection('requests').doc(requestId).update({
      'status': 'pending',
      'nurseId': null,
      'declinedAt': FieldValue.serverTimestamp(),
    });
  }
}
