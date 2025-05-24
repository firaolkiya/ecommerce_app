import 'dart:convert';
import 'package:ecommerce/data/datasources/local/product_local_datasource.dart';
import 'package:ecommerce/data/models/user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProductLocalDatasoureImpl extends ProductLocalDatasource {
  final SharedPreferences sharedPreferences;
  static const String CACHED_USER = 'CACHED_USER';

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
}