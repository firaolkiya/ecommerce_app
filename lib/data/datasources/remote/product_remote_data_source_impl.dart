import 'package:dio/dio.dart';
import 'package:ecommerce/data/datasources/remote/product_remote_data_source.dart';
import 'package:ecommerce/data/models/cart_model.dart';
import 'package:ecommerce/data/models/product_model.dart';
import 'package:ecommerce/data/models/user_model.dart';
import 'package:ecommerce/domain/entities/cart_item.dart';
import 'package:ecommerce/domain/entities/product.dart';

class ProductRemoteDataSourceImpl implements ProductRemoteDataSource {
  final Dio dio;

  ProductRemoteDataSourceImpl({required this.dio});

 @override
Future<List<ProductModel>> getAllProducts() async {
  try {
    print('Calling API...');
    final response = await dio.get('https://fakestoreapi.com/products');
    print('Response received: ${response.statusCode}');

    if (response.statusCode == 200) {
      final List<dynamic> jsonList = response.data;
      final models = jsonList.map((json) => ProductModel.fromJson(json)).toList();
      return models;
    } else {
      throw Exception('Failed to get products. Status code: ${response.statusCode}');
    }
  } catch (e) {
    throw Exception('Failed to get products: ${e.toString()}');
  }
}


  @override
  Future<ProductModel> getProductById(int id) async {
    try {
      final response = await dio.get('/products/$id');
      return ProductModel.fromJson(response.data);
    } catch (e) {
      throw Exception('Failed to get product');
    }
  }

  @override
  Future<List<ProductModel>> getProductsByCategory(String category) async {
    try {
      final response = await dio.get('/products/category/$category');
      return (response.data as List)
          .map((json) => ProductModel.fromJson(json))
          .toList();
    } catch (e) {
      throw Exception('Failed to get products by category');
    }
  }

@override
Future<CartModel> getCart(int userId) async {
  try {
    final response = await dio.get('https://fakestoreapi.com/carts/user/$userId');

    if (response.statusCode == 200 && response.data is List && response.data.isNotEmpty) {
      final cartData = response.data.last;

      final List<dynamic> productList = cartData['products'];
      
      final List<CartItem> cartItems = [];

      for (var item in productList) {
        final productId = item['productId'];
        final quantity = item['quantity'];

        final productRes = await dio.get('https://fakestoreapi.com/products/$productId');

        if (productRes.statusCode == 200) {
          final productModel = ProductModel.fromJson(productRes.data);
          cartItems.add(CartItem(product: productModel, quantity: quantity));
        } else {
          throw Exception('Failed to fetch product $productId');
        }
      }

      return CartModel(
        id: cartData['id'],
        userId: cartData['userId'],
        items: cartItems,
      );
    } else {
      throw Exception('No cart found for this user');
    }
  } catch (e) {
    print('getCart error: $e');
    throw Exception('Failed to get cart: $e');
  }
}
@override
Future<CartModel> addToCart(CartModel cart, ProductEntity product) async {
  try {
    final cartId = cart.id;
    final userId = cart.userId;

    // Clone and update the cart's products
    final updatedProducts = [...cart.items];

    bool found = false;
    for (var item in updatedProducts) {
      if (item.product.id == product.id) {
        item.quantity += 1;
        found = true;
        break;
      }
    }

    if (!found) {
      cart.items.add(CartItem(product: product, quantity: 1));
      updatedProducts.add(CartItem(product: product, quantity: 1));
    }

    // Send PUT request to update the cart
    final response = await dio.put('https://fakestoreapi.com/carts/$cartId', data: {
      'id': cartId,
      'userId': userId,
      'products': updatedProducts
          .map((e) => {'productId': e.product.id, 'quantity': e.quantity})
          .toList(),
    });

    if(response.statusCode!=200){
      throw Exception('Failed to add to cart');
    }

    
    return cart;

   
  } catch (e) {
    throw Exception('Failed to add to cart');
  }
}


  // @override
  // Future<CartModel> removeFromCart(int userId, int productId) async {
  //   try {
  //     final response = await dio.delete(
  //       '/carts/remove',
  //       data: {
  //         'userId': userId,
  //         'productId': productId,
  //       },
  //     );
  //     return CartModel.fromJson(response.data);
  //   } catch (e) {
  //     throw Exception('Failed to remove from cart');
  //   }
  // }

  // @override
  // Future<CartModel> clearCart(int userId) async {
  //   try {
  //     final response = await dio.delete('/carts/clear/$userId');
  //     return CartModel.fromJson(response.data);
  //   } catch (e) {
  //     throw Exception('Failed to clear cart');
  //   }
  // }

  @override
Future<UserModel> login(String username, String password) async {
  try {
    final loginResponse = await dio.post(
      'https://fakestoreapi.com/users',
      data: {
        'username': username,
        'password': password,
      },
    );
    if (loginResponse.statusCode != 200 || loginResponse.data['id'] == null) {
      throw Exception('Invalid credentials');
    }

    // Assuming the login response also returns the user ID
    final int userId = loginResponse.data['id'];
    final userResponse = await dio.get('https://fakestoreapi.com/users/$userId');
    if (userResponse.statusCode != 200 || userResponse.data==null) {
      throw Exception('Failed to retrieve user data');
    }

    return UserModel.fromJson(userResponse.data);
  } catch (e) {
    throw Exception('Failed to login: ${e.toString()}');
  }
}

  

  @override
  Future<CartModel> clearCart(int userId) {
    // TODO: implement clearCart
    throw UnimplementedError();
  }

  @override
  Future<CartModel> removeFromCart(int userId, int productId) {
    // TODO: implement removeFromCart
    throw UnimplementedError();
  }

} 