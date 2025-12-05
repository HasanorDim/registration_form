import 'dart:convert';

class User {
  String name;
  String email;
  String phone;
  String password;
  int age;
  String gender;
  String country;
  String bio;

  User({
    required this.name,
    required this.email,
    required this.phone,
    required this.password,
    required this.age,
    required this.gender,
    required this.country,
    required this.bio,
  });

  // Copy with method for easy updates
  User copyWith({
    String? name,
    String? email,
    String? phone,
    String? password,
    int? age,
    String? gender,
    String? country,
    String? bio,
  }) {
    return User(
      name: name ?? this.name,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      password: password ?? this.password,
      age: age ?? this.age,
      gender: gender ?? this.gender,
      country: country ?? this.country,
      bio: bio ?? this.bio,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'email': email,
      'phone': phone,
      'password': password,
      'age': age,
      'gender': gender,
      'country': country,
      'bio': bio,
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      name: map['name'] ?? '',
      email: map['email'] ?? '',
      phone: map['phone'] ?? '',
      password: map['password'] ?? '',
      age: map['age']?.toInt() ?? 0,
      gender: map['gender'] ?? '',
      country: map['country'] ?? '',
      bio: map['bio'] ?? '',
    );
  }

  String toJson() => jsonEncode(toMap());

  factory User.fromJson(String json) {
    return User.fromMap(jsonDecode(json));
  }

  @override
  String toString() {
    return 'User(name: $name, email: $email, age: $age)';
  }
}
