class ClientProfile {
  final String name;
  final String birth;
  final String phone;
  final String email;

  const ClientProfile({
    required this.name,
    required this.birth,
    required this.phone,
    required this.email,
  });

  factory ClientProfile.fromMap(Map<String, dynamic> map) {
    return ClientProfile(
      name: (map['name'] ?? '').toString(),
      birth: (map['birth'] ?? '').toString(),
      phone: (map['phone'] ?? '').toString(),
      email: (map['email'] ?? '').toString(),
    );
  }

  Map<String, dynamic> toMap() => {
        'name': name,
        'birth': birth,
        'phone': phone,
        'email': email,
      };

  ClientProfile copyWith({
    String? name,
    String? birth,
    String? phone,
    String? email,
  }) {
    return ClientProfile(
      name: name ?? this.name,
      birth: birth ?? this.birth,
      phone: phone ?? this.phone,
      email: email ?? this.email,
    );
  }
}
