import 'dart:convert';

import 'package:flutter/foundation.dart';

// import 'dart:convert';

// import 'package:equatable/equatable.dart';

// class OrderModel extends Equatable {
//   double? id ;
//   final DateTime createdAt;
//   final double totalPrice;
//   final String address;
//   final List<double> items;
//   final bool isPaid;

//   OrderModel({
//     this.id,
//     required this.createdAt,
//     required this.totalPrice,
//     required this.address,
//     required this.items,
//     required this.isPaid
//   });


  
//   @override
//   List<Object> get props {
//     return [id!
//     ];
//   }

//   OrderModel copyWith({
//     double? id ,
//     DateTime? createdAt,
//     double? totalPrice,
//     String? address,
//     List<double>? items,
//     bool? isPaid
//   }) {
//     return OrderModel(
//       id: id ?? this.id,
//       createdAt: createdAt ?? this.createdAt,
//       totalPrice: totalPrice ?? this.totalPrice,
//       address: address ?? this.address,
//       items: items ?? this.items,
//       isPaid: isPaid ?? this.isPaid
//     );
//   }

//   Map<String, dynamic> toMap() {
//     return {
//       'totalPrice': totalPrice,
//       'address': address,
//       'items': items,
//       'isPaid' : isPaid
//     };
//   }

//   factory OrderModel.fromMap(Map<String, dynamic> map) {
//     return OrderModel(
//       id: double.parse(map['id'].toString()),
//       createdAt: DateTime.parse(map['created_at']),
//       totalPrice: map['totalPrice'],
//       address: map['address'],
//       items: (map['items'] as List<dynamic>).map((e) => double.parse(e.toString())).toList(),
//       isPaid: map['is_paid']
//     );
//   }

//   String toJson() => json.encode(toMap());

//   factory OrderModel.fromJson(String source) => OrderModel.fromMap(json.decode(source));

//   @override
//   bool get stringify => true;
// }

class OrderModel {
  int? id;
  final List<int> cartItemsId;
  final String address;
  final List<String> cartItemsName;
  final double totalPrice;
  final String userId;

  OrderModel({
    this.id,
    required this.cartItemsId,
    required this.address,
    required this.cartItemsName,
    required this.totalPrice,
    required this.userId,
  });

  OrderModel copyWith({
    int? id,
    List<int>? cartItemsId,
    String? address,
    List<String>? cartItemsName,
    double? totalPrice,
    String? userId,
  }) {
    return OrderModel(
      id: id ?? this.id,
      cartItemsId: cartItemsId ?? this.cartItemsId,
      address: address ?? this.address,
      cartItemsName: cartItemsName ?? this.cartItemsName,
      totalPrice: totalPrice ?? this.totalPrice,
      userId: userId ?? this.userId,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'cart_items_id': cartItemsId,
      'address': address,
      'cart_items_name': cartItemsName,
      'total_price': totalPrice,
      'user_id': userId,
    };
  }

  factory OrderModel.fromMap(Map<String, dynamic> map) {
    return OrderModel(
      id: map['id']?.toInt(),
      cartItemsId: List<int>.from(map['cart_items_id']),
      address: map['address'] ?? '',
      cartItemsName: List<String>.from(map['cart_items_name']),
      totalPrice: map['total_price']?.toDouble() ?? 0.0,
      userId: map['user_id'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory OrderModel.fromJson(String source) => OrderModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'OrderModel(id: $id, cartItemsId: $cartItemsId, address: $address, cartItemsName: $cartItemsName, totalPrice: $totalPrice, userId: $userId)';
  }


  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is OrderModel &&
      other.id == id &&
      listEquals(other.cartItemsId, cartItemsId) &&
      other.address == address &&
      listEquals(other.cartItemsName, cartItemsName) &&
      other.totalPrice == totalPrice &&
      other.userId == userId;
  }

  @override
  int get hashCode {
    return id.hashCode ^
      cartItemsId.hashCode ^
      address.hashCode ^
      cartItemsName.hashCode ^
      totalPrice.hashCode ^
      userId.hashCode;
  }
}
