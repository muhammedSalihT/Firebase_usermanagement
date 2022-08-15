class UserModel {
  String? uid;
  String? name;
  String? email;
  String? image;
  String? number;

  UserModel({this.uid, this.email, this.image, this.name,this.number});

  factory UserModel.fromJson(Map<String, dynamic> map) => UserModel(
      email: map["email"],
      image: map["image"],
      name: map["name"],
      uid: map["uid"],
      number:map["number"]
      );


  Map<String, dynamic> toJson() =>
      {"uid": uid, "name": name, "email": email, "image": image,"number":number};
}
