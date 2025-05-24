import '../../domain/models/wishlist_product.dart';
import '../../domain/repositories/wishlist_repository.dart';
import '../datasources/local/wishlist_local_datasource.dart';

class WishlistRepositoryImpl implements WishlistRepository {
  final WishlistLocalDataSource _localDataSource;

  WishlistRepositoryImpl(this._localDataSource);

  @override
  Future<List<WishlistProduct>> getWishlist() async {
    return await _localDataSource.getWishlist();
  }

  @override
  Future<void> addToWishlist(WishlistProduct product) async {
    await _localDataSource.addToWishlist(product);
  }

  @override
  Future<void> removeFromWishlist(String productId) async {
    await _localDataSource.removeFromWishlist(productId);
  }

  @override
  Future<bool> isInWishlist(String productId) async {
    return await _localDataSource.isInWishlist(productId);
  }
} 