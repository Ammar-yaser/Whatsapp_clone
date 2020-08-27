class UserContact {
  String contactId;
  String name;
  String mobile;
  String imgUrl;
  String about;

  UserContact({
    this.contactId,
    this.name,
    this.mobile,
    this.imgUrl,
    this.about,
  });

  factory UserContact.fromJson(Map<String, dynamic> data) {
    return UserContact(
      contactId: data['contactId'],
      name: data['name'],
      mobile: data['mobile'],
      imgUrl: data['imgUrl'],
      about: data['about']
    );
  }

   Map<String, dynamic> toMap() {
    return {
      'contactId': contactId,
      'name': name ?? '',
      'mobile': mobile,
      'imgUrl': imgUrl ?? '',
      'about' : about ?? ''
    };
  }
}