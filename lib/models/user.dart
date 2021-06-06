class Users {
  final String uid;
  final String userName;
  final String email;
  final String address;
  final bool isAdmin;
  final String password;

  Users({this.uid, this.userName, this.email, this.address, this.isAdmin, this.password});

  factory Users.fromJson(Map<String, dynamic> json) {
    return Users (
      uid: json['uid'],
      userName: json['userName'],
      email: json['email'],
      address: json['address'],
      isAdmin: json['isAdmin'],
      password: json['password']
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'userName': userName,
      'email': email,
      'address': address,
      'isAdmin': isAdmin,
      'password': password, 
    };
  }

}

