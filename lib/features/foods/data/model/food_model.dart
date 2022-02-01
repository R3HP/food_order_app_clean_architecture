import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:food_order_app/core/model/food_category.dart';
import 'package:food_order_app/features/foods/data/model/ingridient_model.dart';
import 'package:food_order_app/features/foods/domain/enitity/food.dart';
import 'package:food_order_app/features/foods/domain/enitity/ingridient.dart';

class FoodModel extends Equatable{
  final int id;
  final String name;
  final String description;
  final List<Food_Category> categories;
  final List<IngridientModel> ingridients;
  final double price;
  final DateTime createdAt;
  final List<String> pictures;
  final int priceOff ;

  FoodModel(
      {required this.id,
      required this.createdAt,
      required this.name,
      required this.price,
      required this.categories,
      required this.ingridients,
      required this.description,
      required this.pictures,
      required this.priceOff});
      // : super(
      //       name: name,
      //       description: description,
      //       categories: categories,
      //       ingridients: ingridients,
      //       price: price,
      //       id: id,
      //       createdAt: createdAt,
      //       pictures: pictures);

  FoodModel copyWith(
      {int? id,
      DateTime? createdAt,
      String? name,
      String? description,
      List<Food_Category>? categories,
      List<IngridientModel>? ingridients,
      double? price,
      List<String>? pictures,
      int? priceOff}) {
    return FoodModel(
        id: id ?? this.id,
        createdAt: createdAt ?? this.createdAt,
        name: name ?? this.name,
        description: description ?? this.description,
        categories: categories ?? this.categories,
        ingridients: ingridients ?? this.ingridients,
        price: price ?? this.price,
        pictures: pictures ?? this.pictures,
        priceOff: priceOff ?? this.priceOff);
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'created_at': createdAt.toIso8601String(),
      'name': name,
      'price': price,
      'categories': categories.map((e) => e.toString()).toList(),
      'ingridients': ingridients.map((e) => e.toMap()).toList(),
      'description': description,
      'pictures': pictures,
      'priceOff' : priceOff
    };
  }

  factory FoodModel.fromMap(Map<String, dynamic> mapData) {
    return FoodModel(
        id: int.parse(mapData['id'].toString()),
        createdAt: DateTime.parse( mapData['created_at']),
        name: mapData['name'],
        price: double.parse(mapData['price'].toString()),
        categories: (mapData['categories'] as List<dynamic>).map((e) => Food_Category.fromString(e)).toList(),
        ingridients: (mapData['ingridients'] as List<dynamic>).map((ingridient) => IngridientModel.fromMap(ingridient)).toList(),
        description: mapData['description'],
        pictures: (mapData['pictures'] as List<dynamic>).map((e) => e.toString()).toList(),
        priceOff: mapData['priceOFF']
        );
  }

  String toJson() => json.encode(toMap());

  factory FoodModel.fromJson(String source) => FoodModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'FoodModel(name: $name, description: $description, categories: $categories, ingridients: $ingridients, price: $price)';
  }


  double getSellingPrice(){
    var sellingPrice = (100 - priceOff) * price / 100;
    return sellingPrice;
  }

  @override
  // TODO: implement props
  List<Object?> get props => [id];

  // @override
  // // TODO: implement props
  // List<Object?> get props => [id];

  // @override
  // bool operator ==(Object other) {
  //   if (identical(this, other)) return true;

  //   return other is FoodModel &&
  //     other.name == name &&
  //     other.description == description &&
  //     listEquals(other., ) &&
  //     listEquals(other.ingridients, ingridients) &&
  //     other.price == price;
  // }

  // @override
  // int get hashCode {
  //   return name.hashCode ^
  //     description.hashCode ^
  //     .hashCode ^
  //     ingridients.hashCode ^
  //     price.hashCode;
  // }
}
