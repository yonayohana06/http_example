class Product {
  final int id;
  final String title;
  final String description;
  final int price;
  final double discountPercentage;
  final num rating;
  final int stock;
  final String brand;
  final String category;
  final String thumbnail;
  final List<String> images;

  Product({
    required this.id,
    this.title = '',
    this.description = '',
    this.price = 0,
    this.discountPercentage = 0.0,
    this.rating = 0.0,
    this.stock = 0,
    this.brand = '',
    required this.category,
    this.thumbnail = 'https://placeimg.com/100/100',
    this.images = const [],
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'] as int,
      category: json['category'] as String,
      title: json['title'] as String,
      description: json['description'] as String,
      price: json['price'] as int,
      discountPercentage: json['discountPercentage'] as double,
      rating: json['rating'] as num,
      stock: json['stock'] as int,
      brand: json['brand'] as String,
      thumbnail: json['thumbnail'] as String,
      images: List<String>.from(
        json["images"].map((x) => x),
      ),
    );
  }
}
