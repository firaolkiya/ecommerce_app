import 'package:ecommerce/domain/entities/product.dart';
import 'package:flutter/material.dart';
import '../widgets/product_detail/product_image.dart';
import '../widgets/product_detail/product_info.dart';
import '../widgets/product_detail/add_to_cart_button.dart';
import '../widgets/app_background.dart';
import '../widgets/logout_button.dart';

class ProductDetailPage extends StatelessWidget {
  const ProductDetailPage({Key? key, required this.productEntity}) : super(key: key);
  final ProductEntity productEntity;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: const [
          LogOutButton()
        ],
      ),
      body:  AppBackground(
        
        child: Padding(
          padding:  EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child:  Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ProductImage(
                        imageUrl: productEntity.image,
                      ),
                      Flexible(child: SizedBox(height: 40)),
                      ProductInfo(
                        name: productEntity.description,
                        category: productEntity.category,
                        rating: productEntity.rating.rate,
                        reviewCount: productEntity.rating.count,
                        price: '\$${productEntity.price}',
                      ),
                      SizedBox(height: 20),
                      AddToCartButton(),
                    ],
                  ),
            

          ),
        ),
      ),
    );
  }
}