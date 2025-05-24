import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CartItem extends StatelessWidget {
  final String imageUrl;
  final String title;
  final String price;
  final int quantity;

  const CartItem({
    Key? key,
    required this.imageUrl,
    required this.title,
    required this.price,
    required this.quantity,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: Key('delete'),
      direction: DismissDirection.endToStart,
      background: Container(
        color: Color.fromRGBO(204,71,78,1),
        child: const Icon(
              Icons.delete_outline,
              color: Colors.white,
              size: 20,
            ),
      ),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 16),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(4),
              child: Image.network(
                imageUrl,
                width: 60,
                height: 60,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 12),
                    width: 160,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(
                        color: Color.fromRGBO(217, 217, 217, 1)
                      )
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        _buildQuantityButton(Icons.remove),
                        Container(width: 1,color: Color.fromRGBO(217, 217, 217, 1),height: 42,),
                        Container(
                          width: 30,
                          alignment: Alignment.center,
                          child: Text(
                            '$quantity',
                            style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Container(width: 1,color: Color.fromRGBO(217, 217, 217, 1),height: 42,),
                        _buildQuantityButton(Icons.add),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Text(
              price,
              style:  GoogleFonts.urbanist(
                fontSize: 14,
                color: Colors.black,
                fontWeight: FontWeight.w600,
              ),
            ),
            // Container(
            //   width: 40,
            //   height: 40,
            //   decoration: BoxDecoration(
            //     color: Colors.red.shade400,
            //     borderRadius: BorderRadius.circular(4),
            //   ),
            //   child: const Icon(
            //     Icons.delete_outline,
            //     color: Colors.white,
            //     size: 20,
            //   ),
            // ),
          ],
        ),
      ),
    );
  }

  Widget _buildQuantityButton(IconData icon) {
    return Container(
      width: 24,
      height: 24,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(color: Colors.black),
      ),
      child: Icon(
        icon,
        size: 16,
        color: Colors.black,
      ),
    );
  }
}