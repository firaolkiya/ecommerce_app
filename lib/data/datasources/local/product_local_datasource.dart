import 'package:ecommerce/data/models/cart_model.dart';
import 'package:ecommerce/data/models/user_model.dart';

abstract class ProductLocalDatasource{
    Future<UserModel>getCurrentUser();
    Future<void>saveUser(UserModel user);
    Future<void>logout();

    Future<CartModel?>getRecentCart();
    Future<void>storeCart(CartModel cart);
    Future<void>deleteCart();


}