import 'package:ecommerce/data/datasources/local/product_local_datasource.dart';
import 'package:ecommerce/data/datasources/local/product_local_datasource_impl.dart';
import 'package:ecommerce/data/datasources/local/wishlist_local_datasource.dart';
import 'package:ecommerce/data/repositories/auth_repository_impl..dart';
import 'package:ecommerce/data/repositories/cart_repository_impl.dart';
import 'package:ecommerce/data/repositories/wishlist_repository_impl.dart';
import 'package:ecommerce/domain/repositories/auth_repository.dart';
import 'package:ecommerce/domain/repositories/cart_repository.dart';
import 'package:ecommerce/domain/repositories/wishlist_repository.dart';
import 'package:ecommerce/domain/usecases/get_currrent_user_usecase.dart';
import 'package:ecommerce/domain/usecases/login.dart';
import 'package:ecommerce/domain/usecases/logout_usecase.dart';
import 'package:ecommerce/presentation/bloc/auth/auth_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ecommerce/data/datasources/remote/product_remote_data_source.dart';
import 'package:ecommerce/data/datasources/remote/product_remote_data_source_impl.dart';
import 'package:ecommerce/data/repositories/product_repository_impl.dart';
import 'package:ecommerce/domain/repositories/product_repository.dart';
import 'package:ecommerce/domain/usecases/get_all_products.dart';
import 'package:ecommerce/domain/usecases/get_product_by_id.dart';
import 'package:ecommerce/domain/usecases/get_products_by_category.dart';
import 'package:ecommerce/domain/usecases/get_cart.dart';
import 'package:ecommerce/domain/usecases/add_to_cart.dart';
import 'package:ecommerce/domain/usecases/remove_from_cart.dart';
import 'package:ecommerce/domain/usecases/clear_cart.dart';
import 'package:ecommerce/presentation/bloc/product/product_bloc.dart';
import 'package:ecommerce/presentation/bloc/cart/cart_bloc.dart';
import 'package:ecommerce/presentation/bloc/wishlist/wishlist_bloc.dart';

final sl = GetIt.instance;

Future<void> init() async {
  // External
  sl.registerLazySingleton(() => Dio(BaseOptions(
        baseUrl: 'https://api.example.com', // Replace with your API base URL
        connectTimeout: const Duration(seconds: 5),
        receiveTimeout: const Duration(seconds: 3),
      )));

  // Shared Preferences
  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => sharedPreferences);

  // Blocs
  sl.registerFactory(
    () => ProductBloc(
      getAllProducts: sl(),
      getProductById: sl(),
      getProductsByCategory: sl(),
    ),
  );

  sl.registerFactory(
    () => CartBloc(
      getCart: sl(),
      addToCart: sl(),
      removeFromCart: sl(),
      clearCart: sl(),
    ),
  );

   sl.registerFactory(
    () => AuthBloc(
      getUserUsecase: sl(),
      loginUsecase: sl(),
      logoutUsecase: sl()
    ),
  );

  sl.registerFactory(
    () => WishlistBloc(sl()),
  );

  // Use cases
  sl.registerLazySingleton(() => GetAllProducts(sl()));
  sl.registerLazySingleton(() => GetProductById(sl()));
  sl.registerLazySingleton(() => GetProductsByCategory(sl()));
  sl.registerLazySingleton(() => GetCart(sl()));
  sl.registerLazySingleton(() => AddToCart(sl()));
  sl.registerLazySingleton(() => RemoveFromCart(sl()));
  sl.registerLazySingleton(() => ClearCart(sl()));
  sl.registerLazySingleton(() => LoginUsecase(authRepository: sl()));
  sl.registerLazySingleton(() => LogoutUsecase(repository:  sl()));
  sl.registerLazySingleton(() => GetCurrentUserUsecase(authRepository: sl()));
  



  // Repository
  sl.registerLazySingleton<ProductRepository>(
    () => ProductRepositoryImpl(
      remoteDataSource: sl(),
      localDatasource: sl()
    ),
  );

  // register authrepository
  sl.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(
      remoteDatasource: sl(),
      localDatasource: sl()
    ),
  );

  sl.registerLazySingleton<CartRepository>(
    () => CartRepositoryImpl(
      remoteDataSource: sl(),
      localDatasource: sl()
    ),
  );

  sl.registerLazySingleton<WishlistRepository>(
    () => WishlistRepositoryImpl(sl()),
  );

  // Data sources
  // remote
  sl.registerLazySingleton<ProductRemoteDataSource>(
    () => ProductRemoteDataSourceImpl(dio: sl()),
  );

  // local
  sl.registerLazySingleton<ProductLocalDatasource>(
    () => ProductLocalDatasoureImpl(sharedPreferences: sl()),
  );

  sl.registerLazySingleton<WishlistLocalDataSource>(
    () => WishlistLocalDataSource(sl()),
  );
} 