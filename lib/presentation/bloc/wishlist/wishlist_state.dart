import 'package:equatable/equatable.dart';
import '../../../domain/models/wishlist_product.dart';

abstract class WishlistState extends Equatable {
  const WishlistState();

  @override
  List<Object> get props => [];
}

class WishlistInitial extends WishlistState {}

class WishlistLoading extends WishlistState {}

class WishlistLoaded extends WishlistState {
  final List<WishlistProduct> products;
  final Map<String, bool> wishlistStatus;

  const WishlistLoaded({
    required this.products,
    this.wishlistStatus = const {},
  });

  @override
  List<Object> get props => [products, wishlistStatus];

  WishlistLoaded copyWith({
    List<WishlistProduct>? products,
    Map<String, bool>? wishlistStatus,
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