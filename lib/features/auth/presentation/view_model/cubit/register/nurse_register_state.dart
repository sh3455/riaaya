abstract class NurseRegisterState {}

class NurseRegisterInitial extends NurseRegisterState {}

class NurseRegisterLoading extends NurseRegisterState {
  final bool isLoading;
  NurseRegisterLoading([this.isLoading = true]);
}

class NurseRegisterPasswordToggled extends NurseRegisterState {
  final bool obscure;
  NurseRegisterPasswordToggled(this.obscure);
}

class NurseRegisterConfirmPasswordToggled extends NurseRegisterState {
  final bool obscure;
  NurseRegisterConfirmPasswordToggled(this.obscure);
}

class NurseRegisterValidation extends NurseRegisterState {
  final Map<String, String?> errors;
  NurseRegisterValidation(this.errors);
}

class NurseRegisterSuccess extends NurseRegisterState {}

class NurseRegisterError extends NurseRegisterState {
  final String message;
  NurseRegisterError(this.message);
}
