import 'package:ecommerce/presentation/bloc/auth/auth_bloc.dart';
import 'package:ecommerce/presentation/bloc/product/product_bloc.dart';
import 'package:ecommerce/presentation/bloc/product/product_event.dart';
import 'package:ecommerce/presentation/bloc/product/product_state.dart';
import 'package:ecommerce/presentation/bloc/wishlist/wishlist_bloc.dart';
import 'package:ecommerce/presentation/bloc/wishlist/wishlist_event.dart';
import 'package:ecommerce/presentation/bloc/wishlist/wishlist_state.dart';
import 'package:ecommerce/presentation/screens/login.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../widgets/app_background.dart';
import '../widgets/logout_button.dart';
import '../widgets/product_card.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    context.read<ProductBloc>().add(GetAllProductsEvent());
    context.read<WishlistBloc>().add(GetWishlistEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthBloc, AuthState>(
      listener: (context, authState) {
        if(!authState.isLoggedIn){
          Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => LoginPage(),));
        }
      },
      builder: (context, authState) {
        return Scaffold(
            appBar: AppBar(
              toolbarHeight: 80,
              leadingWidth: 230,
              surfaceTintColor: Colors.transparent,
              leading:  Padding(
                padding: const EdgeInsets.only(left: 15.0, top: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Welcome,',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.black54,
                      ),
                    ),
                    (authState.isLoggedIn)?Text(
                      '${authState.currentUser!.name.firstname} ${authState.currentUser!.name.lastname}',
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ):const SizedBox(),
                  ],
                ),
              ),
              actions:  [
                Padding(
                  padding: const EdgeInsets.only(right: 15.0),
                  child: authState.isLoading?const CircularProgressIndicator(): const LogOutButton(),
                ),
              ],
            ),
            body: AppBackground(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: BlocConsumer<ProductBloc, ProductState>(
                    listener: (context, state) {
                  // TODO: implement listener
                }, builder: (context, state) {
                  if (state is ProductError) {
                    return Center(
                      child: Text(state.message),
                    );
                  }
                  if (state is! ProductsLoaded) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 24),
                      const Text(
                        'Fake Store',
                        style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 16),
                      Expanded(
                        child: BlocBuilder<WishlistBloc, WishlistState>(
                            builder: (context, wishListState) {
                              return ListView.separated(
                                separatorBuilder: (context, index) => const SizedBox(height: 10),
                                itemCount: state.products.length,
                                itemBuilder: (context, index) {
                                  final product = state.products[index];
                                  final isFavorite = wishListState is WishlistLoaded
                                      ? wishListState.wishlistStatus[product.id] ?? false
                                      : false;

                                  return ProductCard(
                                    productEntity: product,
                                    isFavorite: isFavorite,
                                  );
                                },
                              );
                            },
                          ),
                      ),
                    ],
                  );
                }),
              ),
            ));
      },
    );
  }
}
