import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../domain/repositories/wishlist_repository.dart';
import 'wishlist_event.dart';
import 'wishlist_state.dart';

class WishlistBloc extends Bloc<WishlistEvent, WishlistState> {
  final WishlistRepository _wishlistRepository;

  WishlistBloc(this._wishlistRepository) : super(WishlistInitial()) {
    on<GetWishlistEvent>(_onGetWishlist);
    on<AddToWishlistEvent>(_onAddToWishlist);
    on<RemoveFromWishlistEvent>(_onRemoveFromWishlist);
    on<CheckWishlistStatusEvent>(_onCheckWishlistStatus);
  }

  Future<void> _onGetWishlist(
    GetWishlistEvent event,
    Emitter<WishlistState> emit,
  ) async {
    emit(WishlistLoading());
    try {
      final products = await _wishlistRepository.getWishlist();
      final wishlistStatus = <int, bool>{};
      
      for (var product in products) {
        wishlistStatus[product.id] = true;
      }
      
      emit(WishlistLoaded(
        products: products,
        wishlistStatus: wishlistStatus,
      ));
    } catch (e) {
      emit(WishlistError(e.toString()));
    }
  }

  Future<void> _onAddToWishlist(
    AddToWishlistEvent event,
    Emitter<WishlistState> emit,
  ) async {
    try {
      await _wishlistRepository.addToWishlist(event.product);
      add(GetWishlistEvent());
    } catch (e) {
      emit(WishlistError(e.toString()));
    }
  }

  Future<void> _onRemoveFromWishlist(
    RemoveFromWishlistEvent event,
    Emitter<WishlistState> emit,
  ) async {
    try {
      await _wishlistRepository.removeFromWishlist(event.productId);
      add(GetWishlistEvent());
    } catch (e) {
      emit(WishlistError(e.toString()));
    }
  }

  Future<void> _onCheckWishlistStatus(
    CheckWishlistStatusEvent event,
    Emitter<WishlistState> emit,
  ) async {
    try {
      add(GetWishlistEvent());
      final isInWishlist = await _wishlistRepository.isInWishlist(event.productId);
      if (state is WishlistLoaded) {
        final currentState = state as WishlistLoaded;
        final updatedStatus = Map<int, bool>.from(currentState.wishlistStatus);
        updatedStatus[event.productId] = isInWishlist;
        
        emit(currentState.copyWith(wishlistStatus: updatedStatus));
      }
    } catch (e) {
      emit(WishlistError(e.toString()));
    }
  }
} 