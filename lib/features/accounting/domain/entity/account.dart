import 'dart:convert';

import 'package:equatable/equatable.dart';

class Account extends Equatable {
  final String id;
  final List<double>? favorits;
  final List<double>? orders;
  final String? phone;
  final String? email;
  final String? username;
  final DateTime created_at;
  final DateTime? birthday;
  const Account({
    required this.id,
    required this.favorits,
    required this.orders,
    required this.phone,
    required this.email,
    required this.username,
    required this.created_at,
    this.birthday,
  });
  


  @override
  List<Object> get props {
    return [
      id
    ];
  }

  Account copyWith({
    String? id,
    List<double>? favorits,
    List<double>? orders,
    String? phone,
    String? email,
    String? username,
    DateTime? created_at,
    DateTime? birthday,
  }) {
    return Account(
      id: id ?? this.id,
      favorits: favorits ?? this.favorits,
      orders: orders ?? this.orders,
      phone: phone ?? this.phone,
      email: email ?? this.email,
      username: username ?? this.username,
      created_at: created_at ?? this.created_at,
      birthday: birthday ?? this.birthday,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'favorits': favorits,
      'orders': orders,
      'phone': phone,
      'email': email,
      'username': username,
      'created_at': created_at.toIso8601String(),
      'birthday': birthday?.toIso8601String(),
    };
  }

  factory Account.fromMap(Map<String, dynamic> map) {
    return Account(
      id: map['id'],
      favorits: map['favorities'] != null ? (map['favorities']! as List<dynamic>).map((e) => double.parse(e)).toList() : [],
      orders: map['orders'] != null ? (map['orders'] as List<dynamic>).map((e) => double.parse(e)).toList() : [],
      phone: map['phone'] ?? null,
      email: map['email'] ?? null,
      username: map['username'] ?? null,
      created_at: DateTime.parse(map['created_at']),
      birthday: map['birthday'] != null ? DateTime.parse(map['birthday']) : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory Account.fromJson(String source) => Account.fromMap(json.decode(source));

  @override
  bool get stringify => true;
}
