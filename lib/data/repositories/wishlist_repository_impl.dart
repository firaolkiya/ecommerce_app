import 'package:ecommerce/data/models/product_model.dart';
import 'package:ecommerce/domain/entities/product.dart';

import '../../domain/models/wishlist_product.dart';
import '../../domain/repositories/wishlist_repository.dart';
import '../datasources/local/wishlist_local_datasource.dart';

class WishlistRepositoryImpl implements WishlistRepository {
  final WishlistLocalDataSource _localDataSource;

  WishlistRepositoryImpl(this._localDataSource);

  @override
  Future<List<ProductEntity>> getWishlist() async {
    return await _localDataSource.getWishlist();
  }

  @override
  Future<void> addToWishlist(ProductEntity product) async {

    await _localDataSource.addToWishlist(product);
  }

  @override
  Future<void> removeFromWishlist(int productId) async {
    await _localDataSource.removeFromWishlist(productId);
  }

  @override
  Future<bool> isInWishlist(int productId) async {
    return await _localDataSource.isInWishlist(productId);
  }
} 