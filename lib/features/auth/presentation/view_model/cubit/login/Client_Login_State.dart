class ClientLoginState {}

class ClientLoginInitial extends ClientLoginState {}

class ClientLoginLoading extends ClientLoginState {}

class ClientLoginSuccess extends ClientLoginState {}

class ClientLoginError extends ClientLoginState {
  final String message;
  ClientLoginError(this.message);
}

class ClientLoginValidation extends ClientLoginState {
  final Map<String, String?> errors;
  ClientLoginValidation(this.errors);
}
