class ProductColor {
  final String colorName;

  ProductColor({required this.colorName});

  factory ProductColor.fromJson(Map<String, dynamic> json) {
    return ProductColor(colorName: json['color_name']);
  }
}

class ProductVariant {
  final int id;
  final ProductColor color;
  final Size size;
  final Thickness thickness;
  final String? image;

  ProductVariant({
    required this.id,
    required this.color,
    required this.size,
    required this.thickness,
    this.image,
  });

  factory ProductVariant.fromJson(Map<String, dynamic> json) {
    return ProductVariant(
      id: json['id'],
      color: ProductColor.fromJson(json['color']),
      size: Size.fromJson(json['size']),
      thickness: Thickness.fromJson(json['thickness']),
      image: json['image'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'color': color.colorName,
      'size': size.sizeValue,
      'thickness': thickness.thicknessValue,
      'image': image,
    };
  }
}

class Size {
  final String sizeValue;

  Size({required this.sizeValue});

  factory Size.fromJson(Map<String, dynamic> json) {
    return Size(sizeValue: json['size_value']);
  }
}

class Thickness {
  final double thicknessValue;

  Thickness({required this.thicknessValue});

  factory Thickness.fromJson(Map<String, dynamic> json) {
    return Thickness(thicknessValue: json['thickness_value'].toDouble());
  }
}

class Product {
  final int id;
  final String name;
  final String brand;
  final String category;
  final String? imageUrl;
  List<ProductVariant>? variants;

  Product({
    required this.id,
    required this.name,
    required this.brand,
    required this.category,
    this.imageUrl,
    this.variants,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'],
      name: json['name'],
      brand: json['brand'],
      category: json['category'],
      imageUrl: json['image'],
      variants: json['variants'] != null 
          ? (json['variants'] as List).map((v) => ProductVariant.fromJson(v)).toList()
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'brand': brand,
      'category': category,
      'image_url': imageUrl,
      'variants': variants?.map((v) => v.toJson()).toList(),
    };
  }
} 