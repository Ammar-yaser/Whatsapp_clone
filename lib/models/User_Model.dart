class User {
  String userId;
  String phone;
  String name;
  String about;
  String profileImage;

  User({
    this.userId,
    this.phone,
    this.name,
    this.about,
    this.profileImage,
  });

  factory User.fromJson(Map<String, dynamic> user) {
    return User(
      userId: user['id'],
      phone: user['phone'],
      name: user['name'],
      about: user['about'],
      profileImage: user['image'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'phone': phone,
      'name': name ?? '',
      'about': about ?? '',
      'image': profileImage ?? '',
    };
  }
}
