import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:riaaya_app/features/request_status/data/model/request_model.dart';

import 'requests_state.dart';

class RequestsCubit extends Cubit<RequestsState> {
  RequestsCubit() : super(RequestsInitial());

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> fetchPendingRequests() async {
    emit(RequestsLoading());

    try {
      final query = await _firestore
          .collection('requests')
          .where('status', isEqualTo: 'pending')
          .get();

      final list = query.docs
          .map((doc) => RequestModel.fromMap(doc.id, doc.data()))
          .toList();

      if (list.isEmpty) {
        emit(RequestsEmpty());
      } else {
        emit(RequestsSuccess(list));
      }
    } catch (e) {
      emit(RequestsFailure(e.toString()));
    }
  }
}
