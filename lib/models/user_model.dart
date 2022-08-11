class UserModel {
  String? uid;
  String? name;
  String? email;
  String? image;

  UserModel({this.uid, this.email, this.image, this.name});

  factory UserModel.fromJson(Map<String, dynamic> map) => UserModel(
      email: map["email"],
      image: map["image"],
      name: map["name"],
      uid: map["uid"]);

  Map<String, dynamic> toJson() =>
      {"uid": uid, "name": name, "email": email, "image": image};
}
