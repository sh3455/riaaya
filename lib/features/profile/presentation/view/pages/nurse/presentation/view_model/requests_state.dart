import 'package:riaaya_app/features/request_status/data/model/request_model.dart';

abstract class RequestsState {}

class RequestsInitial extends RequestsState {}

class RequestsLoading extends RequestsState {}

class RequestsSuccess extends RequestsState {
  final List<RequestModel> requests;
  RequestsSuccess(this.requests);
}

class RequestsEmpty extends RequestsState {}

class RequestsFailure extends RequestsState {
  final String message;
  RequestsFailure(this.message);
}
