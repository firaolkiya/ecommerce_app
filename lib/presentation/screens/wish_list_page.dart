import 'package:ecommerce/presentation/bloc/auth/auth_bloc.dart';
import 'package:ecommerce/presentation/bloc/cart/cart_bloc.dart';
import 'package:ecommerce/presentation/bloc/cart/cart_event.dart';
import 'package:ecommerce/presentation/bloc/cart/cart_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/wishlist/wishlist_bloc.dart';
import '../bloc/wishlist/wishlist_event.dart';
import '../bloc/wishlist/wishlist_state.dart';
import '../widgets/app_background.dart';
import '../widgets/logout_button.dart';
import '../widgets/wishlist/wishlist_item.dart';

class WishlistPage extends StatelessWidget {
  const WishlistPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    int loading=-1;
    return Scaffold(
      body: AppBackground(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Wishlist',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    LogOutButton(),
                  ],
                ),
                const SizedBox(height: 24),
                Expanded(
                  child: BlocBuilder<WishlistBloc, WishlistState>(
                    builder: (context, state) {
                      if (state is WishlistLoading) {
                        return const Center(child: CircularProgressIndicator());
                      } else if (state is WishlistError) {
                        return Center(child: Text(state.message));
                      } else if (state is WishlistLoaded) {
                        if (state.products.isEmpty) {
                          return const Center(
                            child: Text(
                              'Your wishlist is empty',
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.grey,
                              ),
                            ),
                          );
                        }
                        return BlocBuilder<CartBloc, CartState>(

                          builder: (context, cartState) {
                            return ListView.separated(
                              itemCount: state.products.length,
                              separatorBuilder: (context, index) =>
                                  const SizedBox(height: 16),
                              itemBuilder: (context, index) {
                                final product = state.products[index];
                                return WishlistItem(
                                  isLoading: cartState is CartLoading && loading==index,
                                  imageUrl: product.image,
                                  title: product.title,
                                  price:
                                      '\$${product.price.toStringAsFixed(2)}',
                                  onRemove: () {
                                    context.read<WishlistBloc>().add(
                                          RemoveFromWishlistEvent(product.id),
                                        );
                                  },
                                  onAddToCArt: () {
                                    loading=index;
                                    final int userId = context
                                        .read<AuthBloc>()
                                        .state
                                        .currentUser!
                                        .id;
                                    context.read<CartBloc>().add(
                                          AddToCartEvent(
                                              product: state.products[index],
                                              userId: userId),
                                        );
                                  },
                                );
                              },
                            );
                          },
                        );
                      }
                      return const SizedBox.shrink();
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
