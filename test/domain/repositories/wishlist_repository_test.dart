import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';
import 'package:ecommerce/domain/entities/product.dart';
import 'package:ecommerce/domain/entities/rating.dart';
import 'package:ecommerce/domain/repositories/wishlist_repository.dart';
import 'package:ecommerce/data/datasources/local/wishlist_local_datasource.dart';
import 'package:ecommerce/data/repositories/wishlist_repository_impl.dart';
import 'package:ecommerce/data/models/product_model.dart';
import 'package:ecommerce/data/models/rating_model.dart';

  @GenerateMocks([WishlistLocalDataSource])
import 'wishlist_repository_test.mocks.dart';

void main() {
  late MockWishlistLocalDataSource mockLocalDataSource;
  late WishlistRepositoryImpl repository;

  setUp(() {
    mockLocalDataSource = MockWishlistLocalDataSource();
    repository = WishlistRepositoryImpl(mockLocalDataSource);
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

  final tProductModel = ProductModel(
    id: 1,
    title: 'Test Product',
    description: 'Test Description',
    price: 99.99,
    image: 'test.jpg',
    category: 'test',
    rating: RatingModel(rate: 3, count: 30),
  );

  group('getWishlist', () {
    test('should return list of products when call to local data source is successful',
        () async {
      // arrange
      when(mockLocalDataSource.getWishlist())
          .thenAnswer((_) async => [tProductModel]);

      // act
      final result = await repository.getWishlist();

      // assert
      expect(result, [tProductModel]);
      verify(mockLocalDataSource.getWishlist());
      verifyNoMoreInteractions(mockLocalDataSource);
    });

    test('should throw Exception when call to local data source is unsuccessful',
        () async {
      // arrange
      when(mockLocalDataSource.getWishlist())
          .thenThrow(Exception('Failed to load wishlist'));

      // act
      final call = repository.getWishlist;

      // assert
      expect(() => call(), throwsException);
      verify(mockLocalDataSource.getWishlist());
      verifyNoMoreInteractions(mockLocalDataSource);
    });
  });

  group('addToWishlist', () {
    test('should call local data source successfully', () async {
      // arrange
      when(mockLocalDataSource.addToWishlist(tProduct))
          .thenAnswer((_) async => Future.value());

      // act
      await repository.addToWishlist(tProduct);

      // assert
      verify(mockLocalDataSource.addToWishlist(tProduct));
      verifyNoMoreInteractions(mockLocalDataSource);
    });

    test('should throw Exception when call to local data source is unsuccessful',
        () async {
      // arrange
      when(mockLocalDataSource.addToWishlist(tProduct))
          .thenThrow(Exception('Failed to add to wishlist'));

      // act
      final call = repository.addToWishlist;

      // assert
      expect(() => call(tProduct), throwsException);
      verify(mockLocalDataSource.addToWishlist(tProduct));
      verifyNoMoreInteractions(mockLocalDataSource);
    });
  });

  group('removeFromWishlist', () {
    test('should call local data source successfully', () async {
      // arrange
      when(mockLocalDataSource.removeFromWishlist(tProduct.id))
          .thenAnswer((_) async => Future.value());

      // act
      await repository.removeFromWishlist(tProduct.id);

      // assert
      verify(mockLocalDataSource.removeFromWishlist(tProduct.id));
      verifyNoMoreInteractions(mockLocalDataSource);
    });

    test('should throw Exception when call to local data source is unsuccessful',
        () async {
      // arrange
      when(mockLocalDataSource.removeFromWishlist(tProduct.id))
          .thenThrow(Exception('Failed to remove from wishlist'));

      // act
      final call = repository.removeFromWishlist;

      // assert
      expect(() => call(tProduct.id), throwsException);
      verify(mockLocalDataSource.removeFromWishlist(tProduct.id));
      verifyNoMoreInteractions(mockLocalDataSource);
    });
  });

  group('isInWishlist', () {
    test('should return true when product is in wishlist', () async {
      // arrange
      when(mockLocalDataSource.isInWishlist(tProduct.id))
          .thenAnswer((_) async => true);

      // act
      final result = await repository.isInWishlist(tProduct.id);

      // assert
      expect(result, true);
      verify(mockLocalDataSource.isInWishlist(tProduct.id));
      verifyNoMoreInteractions(mockLocalDataSource);
    });

    test('should return false when product is not in wishlist', () async {
      // arrange
      when(mockLocalDataSource.isInWishlist(tProduct.id))
          .thenAnswer((_) async => false);

      // act
      final result = await repository.isInWishlist(tProduct.id);

      // assert
      expect(result, false);
      verify(mockLocalDataSource.isInWishlist(tProduct.id));
      verifyNoMoreInteractions(mockLocalDataSource);
    });

    test('should throw Exception when call to local data source is unsuccessful',
        () async {
      // arrange
      when(mockLocalDataSource.isInWishlist(tProduct.id))
          .thenThrow(Exception('Failed to check wishlist status'));

      // act
      final call = repository.isInWishlist;

      // assert
      expect(() => call(tProduct.id), throwsException);
      verify(mockLocalDataSource.isInWishlist(tProduct.id));
      verifyNoMoreInteractions(mockLocalDataSource);
    });
  });
} 