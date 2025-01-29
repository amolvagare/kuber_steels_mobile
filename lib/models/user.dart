class User {
  final String username;
  final String email;
  final String mobileNo;

  User({
    required this.username,
    required this.email,
    required this.mobileNo,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      username: json['username'] ?? '',
      email: json['email'] ?? '',
      mobileNo: json['mobile_no'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'username': username,
      'email': email,
      'mobile_no': mobileNo,
    };
  }
} 