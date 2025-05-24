import 'package:ecommerce/domain/entities/product.dart';

class CartItem {
  final ProductEntity product;
   int quantity;

  CartItem({
    required this.product,
    required this.quantity,
  });

  Map<String,dynamic>toJson(){
    return {
      'product':product.toJson(),
      'quantity':quantity
    };
  }

  

}
