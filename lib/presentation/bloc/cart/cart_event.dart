import 'package:equatable/equatable.dart';
import 'package:ecommerce/domain/entities/product.dart';

abstract class CartEvent extends Equatable {
  const CartEvent();

  @override
  List<Object> get props => [];
}

class GetCartEvent extends CartEvent {
  final int userId;

  const GetCartEvent(this.userId);

  @override
  List<Object> get props => [userId];
}

class AddToCartEvent extends CartEvent {
  final int userId;
  final ProductEntity product;

  const AddToCartEvent({
    required this.userId,
    required this.product,
  });

  @override
  List<Object> get props => [userId, product];
}

class RemoveFromCartEvent extends CartEvent {
  final int userId;
  final int productId;

  const RemoveFromCartEvent({
    required this.userId,
    required this.productId,
  });

  @override
  List<Object> get props => [userId, productId];
}

class ClearCartEvent extends CartEvent {
  final int userId;

  const ClearCartEvent(this.userId);

  @override
  List<Object> get props => [userId];
} 