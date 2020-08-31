class UserModel {
  String userId;
  String mobile;
  String name;
  String about;
  String imgUrl;

  UserModel({
    this.userId,
    this.mobile,
    this.name,
    this.about,
    this.imgUrl,
  });

  factory UserModel.fromJson(Map<String, dynamic> user) {
    return UserModel(
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
