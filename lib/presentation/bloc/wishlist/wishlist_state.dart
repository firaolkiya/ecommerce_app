import 'package:ecommerce/domain/entities/product.dart';
import 'package:equatable/equatable.dart';

abstract class WishlistState extends Equatable {
  const WishlistState();

  @override
  List<Object> get props => [];
}

class WishlistInitial extends WishlistState {}

class WishlistLoading extends WishlistState {}

class WishlistLoaded extends WishlistState {
  final List<ProductEntity> products;
  final Map<int, bool> wishlistStatus;

  const WishlistLoaded({
    required this.products,
    this.wishlistStatus = const {},
  });

  @override
  List<Object> get props => [products, wishlistStatus];

  WishlistLoaded copyWith({
    List<ProductEntity>? products,
    Map<int, bool>? wishlistStatus,
  }) {
    return WishlistLoaded(
      products: products ?? this.products,
      wishlistStatus: wishlistStatus ?? this.wishlistStatus,
    );
  }
}

class WishlistError extends WishlistState {
  final String message;

  const WishlistError(this.message);

  @override
  List<Object> get props => [message];
} 