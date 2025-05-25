import 'package:ecommerce/domain/entities/product.dart';
import 'package:ecommerce/presentation/bloc/auth/auth_bloc.dart';
import 'package:ecommerce/presentation/bloc/cart/cart_bloc.dart';
import 'package:ecommerce/presentation/bloc/cart/cart_event.dart';
import 'package:ecommerce/presentation/bloc/cart/cart_state.dart';
import 'package:ecommerce/presentation/screens/cart_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../widgets/product_detail/product_image.dart';
import '../widgets/product_detail/product_info.dart';
import '../widgets/product_detail/add_to_cart_button.dart';
import '../widgets/app_background.dart';
import '../widgets/logout_button.dart';

class ProductDetailPage extends StatelessWidget {
  const ProductDetailPage({Key? key, required this.productEntity})
      : super(key: key);
  final ProductEntity productEntity;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(248, 247, 250, 1),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        surfaceTintColor: Colors.transparent,
        actions: const [LogOutButton()],
      ),
      body: BlocConsumer<CartBloc, CartState>(
        listener: (context, state) {
          if(state is CartLoaded){
            ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: const Text('Successfully added to cart'),
                  backgroundColor: Colors.lightBlue.shade300,
                  behavior: SnackBarBehavior.floating,
                  margin: const EdgeInsets.only(top: 16, left: 16, right: 16),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                ),
              );

          }

        },
        builder: (context, state) {
          if(state is CartError){
            return Center(child: Text(state.message),);
          }
          return SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ProductImage(
                  imageUrl: productEntity.image,
                ),
                const Flexible(child: SizedBox(height: 40)),
                ProductInfo(
                  name: productEntity.description,
                  category: productEntity.category,
                  rating: productEntity.rating.rate,
                  reviewCount: productEntity.rating.count,
                  price: '\$${productEntity.price}',
                ),
                const SizedBox(height: 20),
                 Container(
                   height: 100,
                
                    padding: const EdgeInsets.symmetric(vertical: 8,horizontal: 17),
                    width: double.infinity,
                    decoration: const BoxDecoration(
                      color: Color.fromRGBO(255, 232, 178, 1),
                      border: Border(
                        top: BorderSide(color: Colors.black12),
                        bottom: BorderSide(color: Colors.black12),
                      ),
                    ),
                    child: Row(
                      children: [
                        Column(
                          children: [
                            const Text(
                              'Price',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            const SizedBox(height: 8),
                                Text(
                        productEntity.price.toString(),
                        style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                                ),
                              
                          ],
                        ),
                        SizedBox(width: 15,),
                        Expanded(
                          child: AddToCartButton(
                            isLoading:state is CartLoading,
                            onTap: () {
                              final authState = context.read<AuthBloc>().state;
                              if (authState.isLoggedIn ||
                                  authState.currentUser != null) {
                                context.read<CartBloc>().add(AddToCartEvent(
                                    product: productEntity,
                                    userId: authState.currentUser!.id
                                    ));
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content:
                                        Text('You logged out, Please login first'),
                                    backgroundColor: Colors.orange,
                                  ),
                                );
                              }
                            },
                          ),
                        ),
                              
                      ],
                    ),
                  ),
                 
                 ],
            ),
          );
        },
      ),
    );
  }
}
