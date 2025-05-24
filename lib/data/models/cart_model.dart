import 'package:ecommerce/data/models/product_model.dart';
import 'package:ecommerce/domain/entities/cart.dart';
import 'package:ecommerce/domain/entities/cart_item.dart';

class CartModel extends Cart{

  CartModel({required super.id, required super.userId, required super.items});
  
  factory CartModel.fromLocalJson(Map<String,dynamic>json){
    return CartModel(
      id: json['id'], 
      userId: json['uderId'],
      items: (json['items'] as List).map((item)=>
      CartItem(
        product: ProductModel.fromJson(item['product']), 
      quantity: item['quantity'])
      ).toList()
      );
  }

}

