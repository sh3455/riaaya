abstract class NurseRegisterState {}

class NurseRegisterInitial extends NurseRegisterState {}

class NurseRegisterLoading extends NurseRegisterState {}

class NurseRegisterSuccess extends NurseRegisterState {}

class NurseRegisterError extends NurseRegisterState {
  final String message;
  NurseRegisterError(this.message);
}
