import '../models/wishlist_product.dart';

abstract class WishlistRepository {
  Future<List<WishlistProduct>> getWishlist();
  Future<void> addToWishlist(WishlistProduct product);
  Future<void> removeFromWishlist(String productId);
  Future<bool> isInWishlist(String productId);
} 