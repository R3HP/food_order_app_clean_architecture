import 'dart:convert';

class CartItem {
  int? id;
  final String userId;
  final int productId;
  final double pricePerOne;
  final double totalPrice;
  final int quantity;
  final String productName;
  final String imagePath;

  CartItem({
    this.id,
    required this.userId,
    required this.productId,
    required this.pricePerOne,
    required this.totalPrice,
    required this.quantity,
    required this.productName,
    required this.imagePath
  });

  CartItem copyWith({
    int? id,
    String? userId,
    int? productId,
    double? pricePerOne,
    double? totalPrice,
    int? quantity,
    String? productName,
    String? imagePath
  }) {
    return CartItem(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      productId: productId ?? this.productId,
      pricePerOne: pricePerOne ?? this.pricePerOne,
      totalPrice: totalPrice ?? this.totalPrice,
      quantity: quantity ?? this.quantity,
      productName: productName ?? this.productName,
      imagePath: imagePath ?? this.imagePath
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'user_id': userId,
      'product_id': productId,
      'price_per_one': pricePerOne,
      'total_price': totalPrice,
      'quantity': quantity,
      'product_name': productName,
      'image_path' : imagePath
    };
  }

  factory CartItem.fromMap(Map<String, dynamic> map) {
    return CartItem(
      id: map['id'],
      userId: map['user_id'] ?? '',
      productId: map['product_id'] ?? 0,
      pricePerOne: map['price_per_one']?.toDouble() ?? 0.0,
      totalPrice: map['total_price']?.toDouble() ?? 0.0,
      quantity: map['quantity']?.toInt() ?? 0,
      productName: map['product_name'] ?? '',
      imagePath: map['image_path'] ?? ''
    );
  }

  String toJson() => json.encode(toMap());

  factory CartItem.fromJson(String source) => CartItem.fromMap(json.decode(source));

  @override
  String toString() {
    return 'CartItem(id: $id, userId: $userId, productId: $productId, pricePerOne: $pricePerOne, totalPrice: $totalPrice, quantity: $quantity, productName: $productName, imagePath : $imagePath)';
  }

  // @override
  // bool operator ==(Object other) {
  //   if (identical(this, other)) return true;
  
  //   return other is CartItem &&
  //     other.id == id &&
  //     other.userId == userId &&
  //     other.productId == productId &&
  //     other.pricePerOne == pricePerOne &&
  //     other.totalPrice == totalPrice &&
  //     other.quantity == quantity &&
  //     other.productName == productName;
  // }

  // @override
  // int get hashCode {
  //   return id.hashCode ^
  //     userId.hashCode ^
  //     productId.hashCode ^
  //     pricePerOne.hashCode ^
  //     totalPrice.hashCode ^
  //     quantity.hashCode ^
  //     productName.hashCode;
  // }
}
