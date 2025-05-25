import 'package:ecommerce/domain/entities/product.dart';
import 'package:equatable/equatable.dart';

abstract class WishlistEvent extends Equatable {
  const WishlistEvent();

  @override
  List<Object> get props => [];
}

class GetWishlistEvent extends WishlistEvent {}

class AddToWishlistEvent extends WishlistEvent {
  final ProductEntity product;

  const AddToWishlistEvent(this.product);
  @override
  List<Object> get props => [product];
}

class RemoveFromWishlistEvent extends WishlistEvent {
  final int productId;

  const RemoveFromWishlistEvent(this.productId);

  @override
  List<Object> get props => [productId];
}

class CheckWishlistStatusEvent extends WishlistEvent {
  final int productId;

  const CheckWishlistStatusEvent(this.productId);

  @override
  List<Object> get props => [productId];
} 