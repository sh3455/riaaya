abstract class NurseProfileState {
  const NurseProfileState();
}

// ✅ Initial
class NurseProfileInitial extends NurseProfileState {
  const NurseProfileInitial();
}

// ✅ Loading
class NurseProfileLoading extends NurseProfileState {
  const NurseProfileLoading();
}

// ✅ Loaded
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

// ✅ Error
class NurseProfileError extends NurseProfileState {
  final String message;
  const NurseProfileError(this.message);
}
