class Customer {
  final String url;
  final String name;
  final String email;
  final String phone;
  final String address;
  final String city;
  final String pincode;
  final String gstNo;

  Customer({
    required this.url,
    required this.name,
    required this.email,
    required this.phone,
    required this.address,
    required this.city,
    required this.pincode,
    required this.gstNo,
  });

  factory Customer.fromJson(Map<String, dynamic> json) {
    return Customer(
      url: json['url'] ?? '',
      name: json['name'] ?? '',
      email: json['email'] ?? '',
      phone: json['phone'] ?? '',
      address: json['address'] ?? '',
      city: json['city'] ?? '',
      pincode: json['pincode'] ?? '',
      gstNo: json['gst_no'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'url': url,
      'name': name,
      'email': email,
      'phone': phone,
      'address': address,
      'city': city,
      'pincode': pincode,
      'gst_no': gstNo,
    };
  }
} 