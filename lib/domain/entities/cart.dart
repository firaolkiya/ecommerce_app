import 'package:ecommerce/data/models/cart_model.dart';
import 'package:ecommerce/domain/entities/cart_item.dart';

class Cart {
  final int id;
  final int userId;
  final List<CartItem> items;

  Cart({
    required this.id,
    required this.userId,
    required this.items,
  });

  double get totalPrice => items.fold(0, (sum, product) => sum + product.product.price);

 CartModel toModel(){
  return CartModel(id: id, userId: userId, items: items);
 }

 Map<String,dynamic> toJson(){
  return {
    'id':id,
    'userId':userId,
    'items':items.map((item)=>item.toJson()).toList()
  };
 }

} 