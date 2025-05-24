import 'package:ecommerce/data/models/cart_model.dart';
import 'package:ecommerce/data/models/product_model.dart';
import 'package:ecommerce/data/models/user_model.dart';
import 'package:ecommerce/domain/entities/product.dart';

abstract class ProductRemoteDataSource {
  // Product operations
  Future<List<ProductModel>> getAllProducts();
  Future<ProductModel> getProductById(int id);
  Future<List<ProductModel>> getProductsByCategory(String category);

  // Cart operations
  Future<CartModel> getCart(int userId);
  Future<CartModel> addToCart(CartModel cart, ProductEntity product);
  Future<CartModel> removeFromCart(int userId, int productId);
  Future<CartModel> clearCart(int userId);


  // auth

  Future<UserModel>login(String username,String password);
  
} 