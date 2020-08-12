class User {
  String userId;
  String phone;
  String name;
  String profileImage;

  User({
    this.userId,
    this.phone,
    this.name,
    this.profileImage,
  });

  factory User.fromJson(Map<String, dynamic> user) {
    return User(
      userId: user['id'],
      phone: user['phone'],
      name: user['name'],
      profileImage: user['image'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': userId,
      'phone': phone,
      'name': name,
      'image': profileImage,
    };
  }
}
