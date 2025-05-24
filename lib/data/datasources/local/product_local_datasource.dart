import 'package:ecommerce/data/models/user_model.dart';

abstract class ProductLocalDatasource{
    Future<UserModel>getCurrentUser();
    Future<void>saveUser(UserModel user);
    Future<void>logout();


}