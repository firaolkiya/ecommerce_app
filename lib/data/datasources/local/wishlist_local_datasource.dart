import 'dart:convert';
import 'package:ecommerce/data/models/product_model.dart';
import 'package:ecommerce/data/models/rating_model.dart';
import 'package:ecommerce/domain/entities/product.dart';
import 'package:shared_preferences/shared_preferences.dart';

class WishlistLocalDataSource {
  static const String _wishlistKey = 'wishlist';
  final SharedPreferences _prefs;

  WishlistLocalDataSource(this._prefs);

  Future<List<ProductModel>> getWishlist() async {

    try {
      final String? wishlistJson = _prefs.getString(_wishlistKey);
      if (wishlistJson == null) return [];

      final List<dynamic> decodedList = json.decode(wishlistJson);
      return decodedList
          .map((item) => ProductModel.fromJson(item))
          .toList();
    } catch (e) {
      // Optionally log the error
      return [];
    }
  }

  Future<void> addToWishlist(ProductEntity product) async {
    try {
      final List<ProductModel> currentWishlist = await getWishlist();

      // Check if product already exists in wishlist
      if (currentWishlist.any((item) => item.id == product.id)) {
        return;
      }

      final model = ProductModel(
        id: product.id,
        title: product.title,
        price: product.price,
        description: product.description,
        category: product.category,
        image: product.image,
        rating: RatingModel(
          rate: product.rating.rate,
          count: product.rating.count,
        ),
      );

      currentWishlist.add(model);
      await _saveWishlist(currentWishlist);
    } catch (e) {
      print('Error adding to wishlist: $e');
    }
  }

  Future<void> removeFromWishlist(int productId) async {
    try {
      final List<ProductModel> currentWishlist = await getWishlist();
      currentWishlist.removeWhere((item) => item.id == productId);
      await _saveWishlist(currentWishlist);
    } catch (e) {
      print('Error removing from wishlist: $e');
    }
  }

  Future<void> _saveWishlist(List<ProductModel> wishlist) async {
    try {
      final String encodedList = json.encode(
        wishlist.map((product) => product.toJson()).toList(),
      );
      await _prefs.setString(_wishlistKey, encodedList);
    } catch (e) {
      print('Error saving wishlist: $e');
    }
  }

  Future<bool> isInWishlist(int productId) async {
    try {
      final List<ProductModel> wishlist = await getWishlist();
      return wishlist.any((item) => item.id == productId);
    } catch (e) {
      print('Error checking wishlist: $e');
      return false;
    }
  }
}
