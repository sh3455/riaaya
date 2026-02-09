import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:riaaya_app/features/request_status/data/model/rebo/client_requests_repo.dart';
import 'package:riaaya_app/features/request_status/data/model/request_model.dart';


abstract class ClientRequestsState {
  const ClientRequestsState();
}

class ClientRequestsLoading extends ClientRequestsState {}

class ClientRequestsLoaded extends ClientRequestsState {
  final List<RequestModel> list;
  ClientRequestsLoaded(this.list);
}

class ClientRequestsError extends ClientRequestsState {
  final String message;
  ClientRequestsError(this.message);
}

class ClientRequestsCubit extends Cubit<ClientRequestsState> {
  final ClientRequestsRepo repo;
  ClientRequestsCubit(this.repo) : super(ClientRequestsLoading());

  Future<void> load() async {
    emit(ClientRequestsLoading());
    try {
      final list = await repo.getMyRequests();
      emit(ClientRequestsLoaded(list));
    } catch (e) {
      emit(ClientRequestsError(e.toString()));
    }
  }
}
