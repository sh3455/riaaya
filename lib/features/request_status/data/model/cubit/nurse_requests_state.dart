import '../../../data/model/request_model.dart';

abstract class NurseRequestsState {
  const NurseRequestsState();
}

class NurseRequestsLoading extends NurseRequestsState {
  const NurseRequestsLoading();
}

class NurseRequestsLoaded extends NurseRequestsState {
  final List<RequestModel> list;
  final bool isActing; // accept/decline loading
  const NurseRequestsLoaded({
    required this.list,
    this.isActing = false,
  });

  NurseRequestsLoaded copyWith({
    List<RequestModel>? list,
    bool? isActing,
  }) {
    return NurseRequestsLoaded(
      list: list ?? this.list,
      isActing: isActing ?? this.isActing,
    );
  }
}

class NurseRequestsError extends NurseRequestsState {
  final String message;
  const NurseRequestsError(this.message);
}
