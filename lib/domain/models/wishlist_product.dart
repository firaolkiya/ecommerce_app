class WishlistProduct {
  final String id;
  final String name;
  final double price;
  final String imageUrl;
  final String description;

  WishlistProduct({
    required this.id,
    required this.name,
    required this.price,
    required this.imageUrl,
    required this.description,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'price': price,
      'imageUrl': imageUrl,
      'description': description,
    };
  }

  factory WishlistProduct.fromJson(Map<String, dynamic> json) {
    return WishlistProduct(
      id: json['id'] as String,
      name: json['name'] as String,
      price: json['price'] as double,
      imageUrl: json['imageUrl'] as String,
      description: json['description'] as String,
    );
  }
} 