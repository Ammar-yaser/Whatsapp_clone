class User {
  String userId;
  String mobile;
  String name;
  String about;
  String imgUrl;

  User({
    this.userId,
    this.mobile,
    this.name,
    this.about,
    this.imgUrl,
  });

  factory User.fromJson(Map<String, dynamic> user) {
    return User(
      userId: user['userId'],
      mobile: user['mobile'],
      name: user['name'],
      about: user['about'],
      imgUrl: user['imgUrl'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'userId': userId,
      'mobile': mobile,
      'name': name ?? '',
      'about': about ?? "Hey there, I'm using WhatsApp",
      'imgUrl': imgUrl ?? '',
    };
  }
}
