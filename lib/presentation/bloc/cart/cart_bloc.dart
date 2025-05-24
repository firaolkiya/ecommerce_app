import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ecommerce/domain/usecases/get_cart.dart';
import 'package:ecommerce/domain/usecases/add_to_cart.dart';
import 'package:ecommerce/domain/usecases/remove_from_cart.dart';
import 'package:ecommerce/domain/usecases/clear_cart.dart';
import 'package:ecommerce/presentation/bloc/cart/cart_event.dart';
import 'package:ecommerce/presentation/bloc/cart/cart_state.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  final GetCart getCart;
  final AddToCart addToCart;
  final RemoveFromCart removeFromCart;
  final ClearCart clearCart;

  CartBloc({
    required this.getCart,
    required this.addToCart,
    required this.removeFromCart,
    required this.clearCart,
  }) : super(CartInitial()) {
    on<GetCartEvent>(_onGetCart);
    on<AddToCartEvent>(_onAddToCart);
    on<RemoveFromCartEvent>(_onRemoveFromCart);
    on<ClearCartEvent>(_onClearCart);
  }

  Future<void> _onGetCart(
    GetCartEvent event,
    Emitter<CartState> emit,
  ) async {
    emit(CartLoading());
    final result = await getCart(event.userId);
    result.fold(
      (failure) => emit(CartError(failure.message)),
      (cart) => emit(CartLoaded(cart)),
    );
  }

  Future<void> _onAddToCart(
    AddToCartEvent event,
    Emitter<CartState> emit,
  ) async {
    emit(CartLoading());
    final result = await addToCart(event.userId, event.product);
    result.fold(
      (failure) => emit(CartError(failure.message)),
      (cart) => emit(CartLoaded(cart)),
    );
  }

  Future<void> _onRemoveFromCart(
    RemoveFromCartEvent event,
    Emitter<CartState> emit,
  ) async {

    emit(CartLoading());
    final result = await removeFromCart(event.userId, event.productId);
    result.fold(
      (failure) => emit(CartError(failure.message)),
      (cart) => emit(CartLoaded(cart)),
    );
  }

  Future<void> _onClearCart(
    ClearCartEvent event,
    Emitter<CartState> emit,
  ) async {
    emit(CartLoading());
    final result = await clearCart(event.userId);
    result.fold(
      (failure) => emit(CartError(failure.message)),
      (cart) => emit(CartLoaded(cart)),
    );
  }
} 