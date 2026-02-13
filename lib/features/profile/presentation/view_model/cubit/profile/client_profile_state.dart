import 'package:riaaya_app/features/profile/presentation/view_model/cubit/client_profile.dart';

sealed class ClientProfileState {
  const ClientProfileState();
}

class ClientProfileInitial extends ClientProfileState {
  const ClientProfileInitial();
}

class ClientProfileLoading extends ClientProfileState {
  const ClientProfileLoading();
}

class ClientProfileLoaded extends ClientProfileState {
  final ClientProfile profile;
  final bool isSaving;
  const ClientProfileLoaded(this.profile, {this.isSaving = false});

  ClientProfileLoaded copyWith({ClientProfile? profile, bool? isSaving}) {
    return ClientProfileLoaded(
      profile ?? this.profile,
      isSaving: isSaving ?? this.isSaving,
    );
  }
}

class ClientProfileError extends ClientProfileState {
  final String message;
  const ClientProfileError(this.message);
}
