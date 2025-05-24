import 'package:ecommerce/domain/entities/cart_item.dart';
import 'package:ecommerce/domain/entities/product.dart';
import 'package:equatable/equatable.dart';
import 'package:ecommerce/domain/entities/cart.dart';

abstract class CartState extends Equatable {
  const CartState();

  @override
  List<Object> get props => [];
}

class CartInitial extends CartState {}

class CartLoading extends CartState {}

class CartLoaded extends CartState {
  final Cart cart;

  const CartLoaded(this.cart);

  double getTotalPrice(){
    double total=0;
    for(CartItem item in cart.items){
      total+=item.quantity*item.product.price;
    }
    return total; 
  }

  @override
  List<Object> get props => [cart];
}

class CartError extends CartState {
  final String message;

  const CartError(this.message);

  @override
  List<Object> get props => [message];
} 