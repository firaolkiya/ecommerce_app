import 'package:ecommerce/data/models/product_model.dart';
import 'package:ecommerce/domain/entities/rating.dart';

class ProductEntity {
  final int id;
  final String title;
  final double price;
  final String description;
  final String category;
  final String image;
  final RatingEntity rating;

  ProductEntity({
    required this.id,
    required this.title,
    required this.price,
    required this.description,
    required this.category,
    required this.image,
    required this.rating,
  });


  Map<String, dynamic> toJson() {
  return {
    'id': id,
    'title': title,
    'price': price,
    'description': description,
    'category': category,
    'image': image,
    'rating': {
      'rate': rating.rate,
      'count': rating.count,
    },
  };
}


 
}