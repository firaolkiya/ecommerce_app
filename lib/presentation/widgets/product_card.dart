import 'package:ecommerce/core/utils/devices.dart';
import 'package:ecommerce/domain/entities/product.dart';
import 'package:ecommerce/presentation/bloc/wishlist/wishlist_bloc.dart';
import 'package:ecommerce/presentation/bloc/wishlist/wishlist_event.dart';
import 'package:ecommerce/presentation/screens/product_detail_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

class ProductCard extends StatelessWidget {
  final ProductEntity productEntity;
  final bool isFavorite;
  const ProductCard({
    Key? key, required this.productEntity, required this.isFavorite,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Stack(
      children: [
        Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Color.fromARGB(255, 247, 240, 238),
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                  color: const Color.fromRGBO(0, 0, 0, 0.1),
                  blurRadius: 1,
                  spreadRadius: 1,
                ),
              ],
            ),
            child: Row(
              mainAxisAlignment:MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                InkWell(
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(
                      builder: (context) =>ProductDetailPage(
                        productEntity:productEntity
                      ) ,));
                  },
                     child:ClipRRect(
                  borderRadius: BorderRadius.circular(4),
                  child: Image.network(
                    productEntity.image,
                    width: 70,
                    height: 70,
                    fit: BoxFit.cover,
                  ),
                ),
                ),
                const SizedBox(width: 12),
                InkWell(
                  onTap:(){
                    Navigator.push(context, MaterialPageRoute(
                    builder: (context) =>ProductDetailPage(
                      productEntity:productEntity
                    ) ,));
                  },
                  child: SizedBox(
                    width:AppDevices.getDeviceWidth(context)*0.5,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          productEntity.title,                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                  
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style:  GoogleFonts.urbanist(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          productEntity.category,
                          style: GoogleFonts.urbanist(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: Colors.black.withOpacity(0.5),
                          ),
                        ),
                        const SizedBox(height: 4),
                        Row(
                          children: [
                            const Icon(Icons.star, color: Colors.black, size: 16),
                            const SizedBox(width: 4),
                            Text(
                              '${productEntity.rating.rate}',
                              style:  GoogleFonts.urbanist(
                                fontSize: 14,
                                color: Color.fromRGBO(48, 53, 57, 1),
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            
                          ],
                        ),
                        Text(
                        '${productEntity.price  }',
                        style:  GoogleFonts.urbanist(
                          fontSize: 16,
                          color:Colors.black.withOpacity(0.75),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      ],
                    ),
                  ),
                ),

                SizedBox(width: 30,)
                
              ],
            
          ),
        ),
        Positioned(
          right: 20,
          top: 20,
          child: InkWell(
                  onTap:(){
                    if(!isFavorite){
                    context.read<WishlistBloc>().add(AddToWishlistEvent(productEntity));
                    }
                    else{
                    context.read<WishlistBloc>().add(RemoveFromWishlistEvent(productEntity.id));
                    }
                  },
                  child: Icon(
                    isFavorite ? Icons.favorite : Icons.favorite_border,
                    color: isFavorite ? Colors.pink : Colors.purple.shade200,
                    size: 20,
                  ),
                ),)
      ],
    );
  }
}