import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';
import 'package:ecommerce/domain/entities/product.dart';
import 'package:ecommerce/domain/entities/rating.dart';
import 'package:ecommerce/domain/repositories/wishlist_repository.dart';
import 'package:ecommerce/presentation/bloc/wishlist/wishlist_bloc.dart';
import 'package:ecommerce/presentation/bloc/wishlist/wishlist_event.dart';
import 'package:ecommerce/presentation/bloc/wishlist/wishlist_state.dart';

@GenerateMocks([WishlistRepository])
import 'wishlist_bloc_test.mocks.dart';

void main() {
  late MockWishlistRepository mockWishlistRepository;
  late WishlistBloc wishlistBloc;

  setUp(() {
    mockWishlistRepository = MockWishlistRepository();
    wishlistBloc = WishlistBloc(mockWishlistRepository);
  });

  tearDown(() {
    wishlistBloc.close();
  });

  test('initial state should be WishlistInitial', () {
    expect(wishlistBloc.state, equals(WishlistInitial()));
  });

  group('GetWishlistEvent', () {
    final tProducts = [
      ProductEntity(
        id: 1,
        title: 'Test Product',
        description: 'Test Description',
        price: 99.99,
        image: 'test.jpg',
        category: 'test',
        rating: RatingEntity(rate: 3, count: 30),
      ),
    ];
    final tWishlistStatus = {1: true};

    test('should emit [WishlistLoading, WishlistLoaded] when data is gotten successfully',
        () async {
      when(mockWishlistRepository.getWishlist())
          .thenAnswer((_) async => tProducts);

      final expected = [
        WishlistLoading(),
        WishlistLoaded(products: tProducts, wishlistStatus: tWishlistStatus),
      ];
      expectLater(wishlistBloc.stream, emitsInOrder(expected));

      wishlistBloc.add(GetWishlistEvent());
    });

    test('should emit [WishlistLoading, WishlistError] when getting data fails',
        () async {
      when(mockWishlistRepository.getWishlist())
          .thenThrow(Exception('Failed to load wishlist'));

      final expected = [
        WishlistLoading(),
        WishlistError('Exception: Failed to load wishlist'),
      ];
      expectLater(wishlistBloc.stream, emitsInOrder(expected));

      wishlistBloc.add(GetWishlistEvent());
    });
  });

  group('AddToWishlistEvent', () {
    final tProduct = ProductEntity(
      id: 1,
      title: 'Test Product',
      description: 'Test Description',
      price: 99.99,
      image: 'test.jpg',
      category: 'test',
      rating: RatingEntity(rate: 3, count: 30),
    );

    test('should call addToWishlist and then emit [WishlistLoading, WishlistLoaded]', () async {
      when(mockWishlistRepository.addToWishlist(tProduct))
          .thenAnswer((_) async => Future.value());
      when(mockWishlistRepository.getWishlist())
          .thenAnswer((_) async => [tProduct]);

      final tWishlistStatus = {1: true};
      final expected = [
        WishlistLoading(),
        WishlistLoaded(products: [tProduct], wishlistStatus: tWishlistStatus),
      ];
      expectLater(wishlistBloc.stream, emitsInOrder(expected));

      wishlistBloc.add(AddToWishlistEvent(tProduct));
    });

    test('should emit [WishlistError] when addToWishlist throws', () async {
      when(mockWishlistRepository.addToWishlist(tProduct))
          .thenThrow(Exception('Failed to add to wishlist'));

      final expected = [
        WishlistError('Exception: Failed to add to wishlist'),
      ];
      expectLater(wishlistBloc.stream, emitsInOrder(expected));

      wishlistBloc.add(AddToWishlistEvent(tProduct));
    });
  });

  group('RemoveFromWishlistEvent', () {
    final tProduct = ProductEntity(
      id: 1,
      title: 'Test Product',
      description: 'Test Description',
      price: 99.99,
      image: 'test.jpg',
      category: 'test',
      rating: RatingEntity(rate: 3, count: 30),
    );

    test('should call removeFromWishlist and then emit [WishlistLoading, WishlistLoaded]', () async {
      when(mockWishlistRepository.removeFromWishlist(tProduct.id))
          .thenAnswer((_) async => Future.value());
      when(mockWishlistRepository.getWishlist())
          .thenAnswer((_) async => []);

      final tWishlistStatus = <int, bool>{};
      final expected = [
        WishlistLoading(),
        WishlistLoaded(products: [], wishlistStatus: tWishlistStatus),
      ];
      expectLater(wishlistBloc.stream, emitsInOrder(expected));

      wishlistBloc.add(RemoveFromWishlistEvent(tProduct.id));
    });

    test('should emit [WishlistError] when removeFromWishlist throws', () async {
      when(mockWishlistRepository.removeFromWishlist(tProduct.id))
          .thenThrow(Exception('Failed to remove from wishlist'));

      final expected = [
        WishlistError('Exception: Failed to remove from wishlist'),
      ];
      expectLater(wishlistBloc.stream, emitsInOrder(expected));

      wishlistBloc.add(RemoveFromWishlistEvent(tProduct.id));
    });
  });
} 