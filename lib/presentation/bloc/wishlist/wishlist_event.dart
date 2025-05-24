import 'package:equatable/equatable.dart';
import '../../../domain/models/wishlist_product.dart';

abstract class WishlistEvent extends Equatable {
  const WishlistEvent();

  @override
  List<Object> get props => [];
}

class GetWishlistEvent extends WishlistEvent {}

class AddToWishlistEvent extends WishlistEvent {
  final WishlistProduct product;

  const AddToWishlistEvent(this.product);

  @override
  List<Object> get props => [product];
}

class RemoveFromWishlistEvent extends WishlistEvent {
  final String productId;

  const RemoveFromWishlistEvent(this.productId);

  @override
  List<Object> get props => [productId];
}

class CheckWishlistStatusEvent extends WishlistEvent {
  final String productId;

  const CheckWishlistStatusEvent(this.productId);

  @override
  List<Object> get props => [productId];
} 