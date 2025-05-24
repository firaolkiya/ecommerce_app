import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../widgets/app_background.dart';
import '../widgets/logout_button.dart';
import '../widgets/cart/cart_item.dart';
import '../widgets/cart/checkout_button.dart';

class CartPage extends StatelessWidget {
  const CartPage({Key? key}) : super(key: key);

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
                      color: Color.fromRGBO(37, 36, 37, 1),
                      fontSize: 24,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
        ),
        toolbarHeight: 80,
        leadingWidth: 200,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 12.0),
            child: const LogOutButton(),
          ),
        ],
      ),
      body: AppBackground(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              
              Expanded(
                child: ListView(
                  children: const [
                    CartItem(
                      imageUrl: 'assets/images/Book 01.png',
                      title: '"Awaken, My Love!"',
                      price: '\$19.99',
                      quantity: 1,
                    ),
                    SizedBox(height: 10,),
                    CartItem(
                      imageUrl: 'assets/images/Image.png',
                      title: 'Dark Lane Demo Tapes',
                      price: '\$19.99',
                      quantity: 1,
                    ),

                    SizedBox(height: 10,),

                    CartItem(
                      imageUrl: 'assets/images/Book 3.png',
                      title: '4 Your Eyez Only',
                      price: '\$19.99',
                      quantity: 1,
                    ),
                  ],
                ),
              ),
              Container(
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
              CartTotal(total: '\$165.97'),
              SizedBox(width: 22),
              CheckoutButton(),
                  ],
                ),
              )
             
            ],
          ),
        ),
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
            color: Color.fromRGBO(97, 97, 97, 1),
            fontWeight: FontWeight.w500,
          ),
        ),
        Text(
          total,
          style:  GoogleFonts.lora(
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }
}