abstract class ClientLoginState {
  const ClientLoginState();
}

class ClientLoginInitial extends ClientLoginState {
  const ClientLoginInitial();
}

class ClientLoginLoading extends ClientLoginState {
  const ClientLoginLoading();
}

class ClientLoginSuccess extends ClientLoginState {
  const ClientLoginSuccess();
}
class ClientLoginTogglePassword extends ClientLoginState {
  const ClientLoginTogglePassword();
}

class ClientLoginError extends ClientLoginState {
  final String message;
  const ClientLoginError(this.message);
}
