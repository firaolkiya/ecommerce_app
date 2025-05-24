import 'package:ecommerce/presentation/screens/cart_page.dart';
import 'package:ecommerce/presentation/screens/home_page.dart';
import 'package:ecommerce/presentation/screens/wish_list_page.dart';
import 'package:ecommerce/presentation/widgets/bottom_navigation.dart';
import 'package:flutter/material.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  int currentIndex=0;
  List<Widget> pages = [const HomePage(),const WishlistPage(),const CartPage()];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigation(
        currentIndex: currentIndex,
        onSelected: (index){
          setState(() {
            currentIndex=index;
          });
        },
      ),
      body: pages[currentIndex],
    );
  }
}