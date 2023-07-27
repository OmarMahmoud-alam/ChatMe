class SocialUserModel {
  late String name;
  late String email;
  late String phone;
  late String uId;
  late String cover;
  late String bio;
  late int lastseen;
  late List<String?> token;

  SocialUserModel({
    required this.email,
    required this.name,
    required this.phone,
    required this.uId,
    required this.cover,
    required this.bio,
    required this.token,
    required this.lastseen,
  });
  bool differenttime() {
    
    final now = DateTime.now();

    DateTime lasttime = DateTime.fromMillisecondsSinceEpoch(lastseen);
    final difference = now.difference(lasttime);
    return difference.inMinutes <= 10;
  }

  SocialUserModel.fromJson(Map<String, dynamic> json) {
    email = json['email'];
    name = json['name'];
    phone = json['phone'];
    uId = json['uId'];
    cover = json['cover'];
    bio = json['bio'];
    lastseen = json['lastseen'];
    token = (json['token']).cast<String>();
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'email': email,
      'phone': phone,
      'uId': uId,
      'cover': cover,
      'bio': bio,
      'token': token,
      'lastseen': lastseen
    };
  }

  String tostring() {
    String res = "name: $name ,phone: $phone ,bio: $bio ";
    return res;
  }
}
