import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:ecommerce/data/datasources/local/wishlist_local_datasource.dart';
import 'package:ecommerce/domain/entities/product.dart';
import 'package:ecommerce/domain/entities/rating.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import '../../mock_data.mocks.dart'; // <- your mock class file

void main() {
  late WishlistLocalDataSource dataSource;
  late MockSharedPreferences mockPrefs;

  final tProduct = ProductEntity(
    id: 1,
    title: 'Test Product',
    description: 'Test Description',
    price: 99.99,
    image: 'test.jpg',
    category: 'test',
    rating: RatingEntity(rate: 3, count: 30),
  );

  setUp(() {
    mockPrefs = MockSharedPreferences();
    dataSource = WishlistLocalDataSource(mockPrefs);
  });

  group('WishlistLocalDataSource with Mockito', () {
    test('should return empty list when prefs contains null', () async {
      when(mockPrefs.getString(any)).thenReturn(null);

      final result = await dataSource.getWishlist();

      expect(result, []);
      verify(mockPrefs.getString('wishlist')).called(1);
    });


    test('should add product to empty wishlist', () async {
      when(mockPrefs.getString(any)).thenReturn(null);
      when(mockPrefs.setString(any, any)).thenAnswer((_) async => true);

      await dataSource.addToWishlist(tProduct);

      final encoded = jsonEncode([tProduct.toJson()]);
      verify(mockPrefs.setString('wishlist', encoded)).called(1);
    });


    test('should not add duplicate product to wishlist', () async {
      final encoded = jsonEncode(tProduct.toJson());
      when(mockPrefs.getStringList('wishlist')).thenReturn([encoded]);
      when(mockPrefs.setStringList(any, any)).thenAnswer((_) async => true);
      when(mockPrefs.setString(any, any)).thenAnswer((_) async => true);

      await dataSource.addToWishlist(tProduct);

      verifyNever(mockPrefs.setStringList(any, any));

    });

    test('should remove product from wishlist', () async {
        final encoded = jsonEncode(tProduct.toJson());
        when(mockPrefs.getString('wishlist')).thenReturn(jsonEncode([tProduct.toJson()]));
        when(mockPrefs.setString(any, any)).thenAnswer((_) async => true);

        await dataSource.removeFromWishlist(tProduct.id);

        verify(mockPrefs.setString('wishlist', jsonEncode([]))).called(1);
      });

  });
}
