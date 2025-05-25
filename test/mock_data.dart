  import 'package:ecommerce/data/datasources/local/wishlist_local_datasource.dart';
import 'package:ecommerce/domain/repositories/wishlist_repository.dart';
import 'package:mockito/annotations.dart';
import 'package:shared_preferences/shared_preferences.dart';

@GenerateMocks([
  WishlistLocalDataSource,
  SharedPreferences,
  WishlistRepository
  ])


void main(){

}