import 'package:ecommerce/domain/entities/product.dart';
import 'package:equatable/equatable.dart';

class CartItem extends Equatable {
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
  
  @override
  List<Object?> get props => [quantity,product];

  

}
