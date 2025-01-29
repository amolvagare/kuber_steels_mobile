class Product {
  final int id;
  final String name;
  final String brand;
  final String category;
  final String imageUrl;
  final String description;
  final bool isActive;

  Product({
    required this.id,
    required this.name,
    required this.brand,
    required this.category,
    required this.imageUrl,
    required this.description,
    required this.isActive,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
      brand: json['brand'] ?? '',
      category: json['category'] ?? '',
      imageUrl: json['image_url'] ?? '',
      description: json['description'] ?? '',
      isActive: json['is_active'] ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'brand': brand,
      'category': category,
      'image_url': imageUrl,
      'description': description,
      'is_active': isActive,
    };
  }
} 