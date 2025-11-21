class UserInfoModel {
  final String id;
  final DateTime? createdAt;
  final String? name;
  final String? email;

  UserInfoModel({required this.id, this.createdAt, this.name, this.email});

  factory UserInfoModel.fromMap(Map<String, dynamic> map) {
    return UserInfoModel(
      id: map['id']?.toString() ?? '',
      createdAt: map['created_at'] != null
          ? DateTime.parse(map['created_at'].toString())
          : null,
      name: map['name']?.toString(),
      email: map['email']?.toString(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'created_at': createdAt?.toIso8601String(),
      'name': name,
      'email': email,
    };
  }

  bool get isEmpty => id.isEmpty;

  UserInfoModel copyWith({
    String? id,
    DateTime? createdAt,
    String? name,
    String? email,
  }) {
    return UserInfoModel(
      id: id ?? this.id,
      createdAt: createdAt ?? this.createdAt,
      name: name ?? this.name,
      email: email ?? this.email,
    );
  }
}
