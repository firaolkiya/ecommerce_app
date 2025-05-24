import 'dart:convert';
import 'package:ecommerce/data/datasources/local/product_local_datasource.dart';
import 'package:ecommerce/data/models/cart_model.dart';
import 'package:ecommerce/data/models/user_model.dart';
import 'package:ecommerce/domain/entities/cart.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProductLocalDatasoureImpl extends ProductLocalDatasource {
  final SharedPreferences sharedPreferences;
  static const String CACHED_USER = 'CACHED_USER';
  static const String CACHED_CART = 'CACHED_CART';

  ProductLocalDatasoureImpl({required this.sharedPreferences});

  @override
  Future<UserModel> getCurrentUser() async {
    final jsonString = sharedPreferences.getString(CACHED_USER);
    if (jsonString != null) {
      return UserModel.fromJson(json.decode(jsonString));
    } else {
      throw Exception('No cached user found');
    }
  }

  @override
  Future<void> logout() async {
    await sharedPreferences.remove(CACHED_USER);
  }

  @override
  Future<void> saveUser(UserModel user) async {
    await sharedPreferences.setString(
      CACHED_USER,
      json.encode(user.toJson()),
    );
  }

  @override
Future<void> storeCart(CartModel cart) async {
  final cartJson = json.encode(cart.toJson());
  await sharedPreferences.setString(CACHED_CART, cartJson);
}

@override
Future<CartModel?> getRecentCart() async {
  final jsonString = sharedPreferences.getString(CACHED_CART);
  if (jsonString != null) {
    return CartModel.fromLocalJson(json.decode(jsonString));
  } else {
    return null; // No cached cart
  }
}

@override
Future<void> deleteCart() async {
  await sharedPreferences.remove(CACHED_CART);
}

}