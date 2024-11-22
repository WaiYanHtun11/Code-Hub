class User{
  String uid;
  String name;
  String mail;
  String image;
  User({required this.uid,required this.name,required this.mail,required this.image});

  Map<String, String> toMap() {
    return {
      'uid': uid,
      'name': name,
      'mail': mail,
      'image': image,
    };
  }

  // Create a User from Map
  factory User.fromMap(Map<String, String> map) {
    return User(
      uid: map['uid'] ?? '',
      name: map['name'] ?? '',
      mail: map['mail'] ?? '',
      image: map['image'] ?? '',
    );
  }
}
