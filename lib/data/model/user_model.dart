class UserModel {
  //late String uid, email, name;
  //late String pic;
  late String userId;
  late String email;
  late String name;
  late String pic;

  UserModel(
      {this.userId = "",
      this.email = "",
      this.name = "",
      this.pic =
          "https://firebasestorage.googleapis.com/v0/b/e-commerce-bbf5d.appspot.com/o/120.png?alt=media&token=7fbb8ba7-8451-4fe7-85eb-8afe850f95d7"});

  UserModel.fromJson(Map<dynamic, dynamic>? map) {
    if (map == null) {
      return;
    }
    userId = map['userId'];
    email = map['email'];
    name = map['name'];
    pic = map['pic'];
  }

  toJson() {
    return {
      'userId': userId,
      'email': email,
      'name': name,
      'pic': pic,
    };
  }
}
