import 'package:ecommerce/domain/entities/product.dart';

class Cart {
  final int id;
  final int userId;
  final List<ProductEntity> products;

  Cart({
    required this.id,
    required this.userId,
    required this.products,
  });

  double get totalPrice => products.fold(0, (sum, product) => sum + product.price);


} 