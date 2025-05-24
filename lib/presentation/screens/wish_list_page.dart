import 'package:flutter/material.dart';
import '../widgets/app_background.dart';
import '../widgets/logout_button.dart';
import '../widgets/bottom_navigation.dart';
import '../widgets/wishlist/wishlist_item.dart';

class WishlistPage extends StatelessWidget {
  const WishlistPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AppBackground(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Wishlist',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const LogOutButton(),
                  ],
                ),
                const SizedBox(height: 24),
                Expanded(
                  child: ListView(
                    children: const [
                      WishlistItem(
                        imageUrl: 'assets/images/Book 01.png',
                        title: '"Awaken, My Love!"',
                        price: '\$19.99',
                      ),
                      SizedBox(height: 16),
                      WishlistItem(
                        imageUrl: 'assets/images/Book 2.png',
                        title: 'Dark Lane Demo Tapes',
                        price: '\$32.99',
                      ),
                      SizedBox(height: 16),
                      WishlistItem(
                        imageUrl: 'assets/images/Book 3.png',
                        title: '4 Your Eyez Only',
                        price: '\$28.99',
                      ),
                    ],
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