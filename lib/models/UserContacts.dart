class UserContacts {
  String contactId;
  String name;
  String mobile;
  String image;

  UserContacts({
    this.contactId,
    this.name,
    this.mobile,
    this.image,
  });

  factory UserContacts.fromJson(Map<String, dynamic> data) {
    return UserContacts(
      contactId: data['contactId'],
      name: data['name'],
      mobile: data['mobile'],
      image: data['image'],
    );
  }

   Map<String, dynamic> toMap() {
    return {
      'contactId': contactId,
      'name': name ?? '',
      'mobile': mobile,
      'image': image ?? '',
    };
  }
}
