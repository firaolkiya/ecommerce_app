import 'package:ecommerce/domain/entities/cart.dart';
import 'package:ecommerce/domain/entities/product.dart';
import 'package:ecommerce/data/models/product_model.dart';

class CartModel extends Cart {
  CartModel({
    required int id,
    required int userId,
    required List<ProductEntity> products,
  }) : super(
          id: id,
          userId: userId,
          products: products,
        );

  factory CartModel.fromJson(Map<String, dynamic> json) {
    return CartModel(
      id: json['id'] as int,
      userId: json['userId'] as int,
      products: (json['products'] as List)
          .map((product) => ProductModel.fromJson(product))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userId': userId,
      'products': products.map((product) => (product as ProductModel).toJson()).toList(),
    };
  }
} 