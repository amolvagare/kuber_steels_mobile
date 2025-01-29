class CartItem {
  final String productId;
  final String productName;
  final String category;
  final String brand;
  final double quantity;
  final String unit; // e.g., "kg", "pieces", "meters"
  final String? notes;
  final String customerId;

  CartItem({
    required this.productId,
    required this.productName,
    required this.category,
    required this.brand,
    required this.quantity,
    required this.unit,
    required this.customerId,
    this.notes,
  });

  Map<String, dynamic> toJson() {
    return {
      'product_id': productId,
      'product_name': productName,
      'category': category,
      'brand': brand,
      'quantity': quantity,
      'unit': unit,
      'notes': notes,
      'customer_id': customerId,
    };
  }
} 