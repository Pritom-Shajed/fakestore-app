import 'dart:convert';

import 'package:auth/src/features/cart/data/models/product_model_hive.dart';
import 'package:auth/src/features/home/domain/entity/product_entity.dart';

class ProductModel extends ProductEntity {
  ProductModel({
    required super.id,
    required super.title,
    required super.price,
    required super.description,
    required super.category,
    required super.image,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      id: json[_Json.id],
      title: json[_Json.title],
      price: (json[_Json.price] as num).toDouble(),
      description: json[_Json.description],
      category: json[_Json.category],
      image: json[_Json.image],
    );
  }

  factory ProductModel.fromRawJson(String str) => ProductModel.fromJson(json.decode(str));

  static List<ProductModel> fromJsonList(List<Map<String, dynamic>> jsonList) =>
      jsonList.map((e) => ProductModel.fromJson(e)).toList();

  static List<Map<String, dynamic>> toJsonList(List<ProductModel> list) => list.map((e) => e.toJson()).toList();

  Map<String, dynamic> toJson() {
    return {
      _Json.id: id,
      _Json.title: title,
      _Json.price: price,
      _Json.description: description,
      _Json.category: category,
      _Json.image: image,
    };
  }

  String toRawJson() => json.encode(toJson());

  @override
  String toString() => toRawJson();

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is ProductModel && other.id == id && other.title == title && other.image == image;
  }

  @override
  int get hashCode => id.hashCode ^ title.hashCode ^ image.hashCode;

  ProductModel copyWith({
    int? id,
    String? title,
    double? price,
    String? description,
    String? category,
    String? image,
  }) {
    return ProductModel(
      id: id ?? this.id,
      title: title ?? this.title,
      price: price ?? this.price,
      description: description ?? this.description,
      category: category ?? this.category,
      image: image ?? this.image,
    );
  }

  // To Hive

  ProductModelHive toHive() {
    return ProductModelHive(
      id: id,
      title: title,
      price: price,
      description: description,
      category: category,
      image: image,
    );
  }
}

class _Json {
  static const id = 'id';
  static const title = 'title';
  static const price = 'price';
  static const description = 'description';
  static const category = 'category';
  static const image = 'image';
}
