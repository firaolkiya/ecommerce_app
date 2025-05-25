import 'package:ecommerce/data/datasources/local/wishlist_local_datasource.dart';
import 'package:ecommerce/domain/entities/rating.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ecommerce/domain/entities/product.dart';
import 'package:flutter/material.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  late WishlistLocalDataSource dataSource;
  late SharedPreferences sharedPreferences;

  setUp(() async {
    sharedPreferences = await SharedPreferences.getInstance();
    await sharedPreferences.clear();
    dataSource = WishlistLocalDataSource(sharedPreferences);
  });

  final tProduct = ProductEntity(
    id: 1,
    title: 'Test Product',
    description: 'Test Description',
    price: 99.99,
    image: 'test.jpg',
    category: 'test',
    rating: RatingEntity(rate: 3, count: 30),
  );

  group('getWishlist', () {
    test('should return empty list when no products are stored', () async {
      final result = await dataSource.getWishlist();
      expect(result, []);
    });
  });

  group('addToWishlist', () {
    test('should add product to wishlist when wishlist is empty', () async {
      await dataSource.addToWishlist(tProduct);
      final storedProducts = await dataSource.getWishlist();
      expect(storedProducts, [tProduct]);
    });

    test('should add product to existing wishlist', () async {
      final existingProduct = ProductEntity(
        id: 2,
        title: 'Existing Product',
        description: 'Existing Description',
        price: 149.99,
        image: 'existing.jpg',
        category: 'test',
        rating: RatingEntity(rate: 4, count: 10),
      );
      await dataSource.addToWishlist(existingProduct);
      await dataSource.addToWishlist(tProduct);
      final storedProducts = await dataSource.getWishlist();
      expect(storedProducts, [existingProduct, tProduct]);
    });

    test('should not add duplicate product to wishlist', () async {
      await dataSource.addToWishlist(tProduct);
      await dataSource.addToWishlist(tProduct);
      final storedProducts = await dataSource.getWishlist();
      expect(storedProducts, [tProduct]);
    });
  });

  group('removeFromWishlist', () {
    test('should remove product from wishlist', () async {
      await dataSource.addToWishlist(tProduct);
      await dataSource.removeFromWishlist(tProduct.id);
      final storedProducts = await dataSource.getWishlist();
      expect(storedProducts, []);
    });

    test('should return empty list when removing from empty wishlist', () async {
      await dataSource.removeFromWishlist(tProduct.id);
      final storedProducts = await dataSource.getWishlist();
      expect(storedProducts, []);
    });

    test('should remove only specified product from wishlist', () async {
      final existingProduct = ProductEntity(
        id: 2,
        title: 'Existing Product',
        description: 'Existing Description',
        price: 149.99,
        image: 'existing.jpg',
        category: 'test',
        rating: RatingEntity(rate: 4, count: 10),
      );
      await dataSource.addToWishlist(existingProduct);
      await dataSource.addToWishlist(tProduct);
      await dataSource.removeFromWishlist(tProduct.id);
      final storedProducts = await dataSource.getWishlist();
      expect(storedProducts, [existingProduct]);
    });
  });
} 