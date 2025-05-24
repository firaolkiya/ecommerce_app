import 'package:ecommerce/domain/entities/product.dart';

class CartItem {
  final ProductEntity product;
  final int quantity;

  CartItem({
    required this.product,
    required this.quantity,
  });
}
