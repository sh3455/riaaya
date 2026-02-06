import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:riaaya_app/features/auth/data/client_profile_repository.dart';
import 'package:riaaya_app/features/auth/presentation/view_model/client_profile.dart';

import 'client_profile_state.dart';

class ClientProfileCubit extends Cubit<ClientProfileState> {
  final ClientProfileRepository repo;
  final String uid;

  StreamSubscription<ClientProfile>? _sub;

  ClientProfileCubit({required this.repo, required this.uid})
      : super(const ClientProfileInitial());

  void start() {
    emit(const ClientProfileLoading());
    _sub?.cancel();
    _sub = repo.watchClient(uid).listen(
      (profile) {
        emit(ClientProfileLoaded(profile));
      },
      onError: (e) {
        emit(ClientProfileError(e.toString()));
      },
    );
  }

  Future<void> updateFields(Map<String, dynamic> updates) async {
    final current = state;
    if (current is! ClientProfileLoaded) return;

    emit(current.copyWith(isSaving: true));
    try {
      await repo.updateClient(uid, updates);
      // Stream هيجيب آخر نسخة تلقائي
    } catch (e) {
      emit(ClientProfileError("Update failed: $e"));
      // رجّع تاني آخر بيانات لو حابب
      emit(ClientProfileLoaded(current.profile));
    }
  }

  @override
  Future<void> close() {
    _sub?.cancel();
    return super.close();
  }
}
