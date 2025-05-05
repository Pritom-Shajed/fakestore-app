import 'package:auth/src/features/home/data/models/product_model.dart';
import 'package:auth/src/features/settings/data/repositories/hive_box.dart';
import 'package:hive_ce/hive.dart';
import 'package:uuid/uuid.dart';

part 'product_model_hive.g.dart';

@HiveType(typeId: HiveTypes.productsCart)
class ProductModelHive extends HiveObject {
  @HiveField(0)
  int id;

  @HiveField(1)
  String title;

  @HiveField(2)
  double price;

  @HiveField(3)
  String description;

  @HiveField(4)
  String category;

  @HiveField(5)
  String image;

  @HiveField(6)
  String hashKey;

  ProductModelHive({
    required this.id,
    required this.title,
    required this.price,
    required this.description,
    required this.category,
    required this.image,
    String? hashKey,
  }) : hashKey = hashKey ?? const Uuid().v4();

  factory ProductModelHive.fromJson(Map<String, dynamic> json) {
    return ProductModelHive(
      id: json['id'],
      title: json['title'],
      price: (json['price'] as num).toDouble(),
      description: json['description'],
      category: json['category'],
      image: json['image'],
      hashKey: const Uuid().v4(),
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'price': price,
        'description': description,
        'category': category,
        'image': image,
      };

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is ProductModelHive && other.hashKey == hashKey;
  }

  @override
  int get hashCode => hashKey.hashCode;

    ProductModel toModel() {
    return ProductModel(
      id: id,
      title: title,
      price: price,
      description: description,
      category: category,
      image: image,
    );
  }
}
