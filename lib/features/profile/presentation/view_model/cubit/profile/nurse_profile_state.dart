abstract class NurseProfileState {
  const NurseProfileState();
}

class NurseProfileInitial extends NurseProfileState {
  const NurseProfileInitial();
}

class NurseProfileLoading extends NurseProfileState {
  const NurseProfileLoading();
}

class NurseProfileLoaded extends NurseProfileState {
  final Map<String, dynamic> data;
  final bool isSaving;

  const NurseProfileLoaded({
    required this.data,
    this.isSaving = false,
  });

  NurseProfileLoaded copyWith({
    Map<String, dynamic>? data,
    bool? isSaving,
  }) {
    return NurseProfileLoaded(
      data: data ?? this.data,
      isSaving: isSaving ?? this.isSaving,
    );
  }
}

class NurseProfileError extends NurseProfileState {
  final String message;
  const NurseProfileError(this.message);
}
