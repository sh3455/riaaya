import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:riaaya_app/features/request_status/data/model/rebo/nurse_requests_repo.dart';

import 'nurse_requests_state.dart';

class NurseRequestsCubit extends Cubit<NurseRequestsState> {
  final NurseRequestsRepo repo;

  NurseRequestsCubit(this.repo) : super(const NurseRequestsLoading());

  Future<void> load() async {
    emit(const NurseRequestsLoading());
    try {
      final list = await repo.getAvailableRequests();
      emit(NurseRequestsLoaded(list: list));
    } catch (e) {
      emit(NurseRequestsError(e.toString()));
    }
  }

  Future<void> accept(String requestId) async {
    final current = state;
    if (current is! NurseRequestsLoaded) return;

    emit(current.copyWith(isActing: true));
    try {
      await repo.acceptRequest(requestId);

      // Reload بعد القبول
      final list = await repo.getAvailableRequests();
      emit(NurseRequestsLoaded(list: list));
    } catch (e) {
      emit(NurseRequestsError(e.toString()));
      emit(current.copyWith(isActing: false));
    }
  }

  Future<void> decline(String requestId) async {
    final current = state;
    if (current is! NurseRequestsLoaded) return;

    emit(current.copyWith(isActing: true));
    try {
      await repo.declineRequest(requestId);

      final list = await repo.getAvailableRequests();
      emit(NurseRequestsLoaded(list: list));
    } catch (e) {
      emit(NurseRequestsError(e.toString()));
      emit(current.copyWith(isActing: false));
    }
  }
}
