import 'package:ecommerce/domain/entities/product.dart';

import '../models/wishlist_product.dart';

abstract class WishlistRepository {
  Future<List<ProductEntity>> getWishlist();
  Future<void> addToWishlist(ProductEntity product);
  Future<void> removeFromWishlist(int productId);
  Future<bool> isInWishlist(int productId);
} 