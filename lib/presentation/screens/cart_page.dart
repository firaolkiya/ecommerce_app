import 'package:ecommerce/presentation/bloc/auth/auth_bloc.dart';
import 'package:ecommerce/presentation/bloc/cart/cart_bloc.dart';
import 'package:ecommerce/presentation/bloc/cart/cart_event.dart';
import 'package:ecommerce/presentation/bloc/cart/cart_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import '../widgets/app_background.dart';
import '../widgets/logout_button.dart';
import '../widgets/cart/cart_item.dart';
import '../widgets/cart/checkout_button.dart';

class CartPage extends StatefulWidget {
  const CartPage({Key? key}) : super(key: key);

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  @override
  void initState() {
    final int userId = context.read<AuthBloc>().state.currentUser!.id;
    final cartBloc = context.read<CartBloc>();
    if(cartBloc.state is !CartLoaded){
      cartBloc.add(GetCartEvent(userId));
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: Padding(
          padding: const EdgeInsets.all(22.0),
          child: Text(
            'Cart',
            style: GoogleFonts.urbanist(
              color: const Color.fromRGBO(37, 36, 37, 1),
              fontSize: 24,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        toolbarHeight: 80,
        leadingWidth: 200,
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 12.0),
            child: LogOutButton(),
          ),
        ],
      ),
      body: BlocConsumer<CartBloc, CartState>(
        listener: (context, state) {
          // TODO: implement listener
        },
        builder: (context, state) {
          if(state is CartError){
            return Center(child: Text(state.message),);
          }
          if(state is CartLoaded){
          final cartItems = state.cart.items;
          return AppBackground(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: ListView.separated(
                      shrinkWrap: true,
                      itemCount: cartItems.length,
                      itemBuilder: (context, index) =>  CartItem(
                          imageUrl: cartItems[index].product.image,
                          title: cartItems[index].product.title,
                          price: '\$${cartItems[index].product.price}',
                          quantity: cartItems[index].quantity,
                        ),
                        separatorBuilder: (context, index) => const SizedBox(height: 15,),
                    ),
                  ),
                  Divider(),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      CartTotal(total: '\$${state.getTotalPrice()}'),
                      const SizedBox(width: 22),
                      const CheckoutButton(),
                    ],
                  )
                ],
              ),
            ),
          );
          }
          return const Center(child: CircularProgressIndicator(),);
        },
      ),
    );
  }
}

class CartTotal extends StatelessWidget {
  final String total;

  const CartTotal({
    Key? key,
    required this.total,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          'Cart total',
          style: GoogleFonts.inter(
            fontSize: 14,
            color: const Color.fromRGBO(97, 97, 97, 1),
            fontWeight: FontWeight.w500,
          ),
        ),
        Text(
          total,
          style: GoogleFonts.lora(
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }
}
