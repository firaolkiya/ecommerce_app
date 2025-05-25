import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ProductInfo extends StatelessWidget {
  final String name;
  final String category;
  final double rating;
  final int reviewCount;
  final String price;

  const ProductInfo({
    Key? key,
    required this.name,
    required this.category,
    required this.rating,
    required this.reviewCount,
    required this.price,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(17.0),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              name,
              style: GoogleFonts.urbanist(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Color.fromRGBO(0, 0, 0, 0.75),
              ),
            ),
            const SizedBox(height: 4),
            Text(
              category,
              style: GoogleFonts.urbanist(
                fontSize: 14,
                color: const Color.fromRGBO(0, 0, 0, 0.5),
              ),
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                const Icon(Icons.star, color: Colors.black, size: 18),
                const SizedBox(width: 4),
                Text(
                  '$rating',
                  style: GoogleFonts.urbanist(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(width: 4),
                Text(
                  '$reviewCount Reviews',
                  style: GoogleFonts.urbanist(
                    fontSize: 14,
                    color: const Color.fromARGB(255, 166, 166, 170),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
           
          ],
        ),
      ),
    );
  }
}