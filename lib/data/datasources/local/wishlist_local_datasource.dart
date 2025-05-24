import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../domain/models/wishlist_product.dart';

class WishlistLocalDataSource {
  static const String _wishlistKey = 'wishlist';
  final SharedPreferences _prefs;

  WishlistLocalDataSource(this._prefs);

  Future<List<WishlistProduct>> getWishlist() async {
    final String? wishlistJson = _prefs.getString(_wishlistKey);
    if (wishlistJson == null) return [];

    final List<dynamic> decodedList = json.decode(wishlistJson);
    return decodedList
        .map((item) => WishlistProduct.fromJson(item))
        .toList();
  }

  Future<void> addToWishlist(WishlistProduct product) async {
    final List<WishlistProduct> currentWishlist = await getWishlist();
    
    // Check if product already exists in wishlist
    if (currentWishlist.any((item) => item.id == product.id)) {
      return;
    }

    currentWishlist.add(product);
    await _saveWishlist(currentWishlist);
  }

  Future<void> removeFromWishlist(String productId) async {
    final List<WishlistProduct> currentWishlist = await getWishlist();
    currentWishlist.removeWhere((item) => item.id == productId);
    await _saveWishlist(currentWishlist);
  }

  Future<void> _saveWishlist(List<WishlistProduct> wishlist) async {
    final String encodedList = json.encode(
      wishlist.map((product) => product.toJson()).toList(),
    );
    await _prefs.setString(_wishlistKey, encodedList);
  }

  Future<bool> isInWishlist(String productId) async {
    final List<WishlistProduct> wishlist = await getWishlist();
    return wishlist.any((item) => item.id == productId);
  }
} 