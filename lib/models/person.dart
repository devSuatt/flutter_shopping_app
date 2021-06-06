class Person {
  final String personId;
  final String userName;
  final String email;
  final String address;
  final String imageUrl;
  final bool isAdmin;
  final String password;

  Person({this.personId, this.userName, this.email, this.address, this.imageUrl, this.isAdmin, this.password});

  factory Person.fromJson(Map<String, dynamic> json) {
    return Person (
      personId: json['personId'],
      userName: json['userName'],
      email: json['email'],
      address: json['address'],
      imageUrl: json['imageUrl'],
      isAdmin: json['isAdmin'],
      password: json['password']
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'personId': personId,
      'userName': userName,
      'email': email,
      'address': address,
      'imageUrl': imageUrl,
      'isAdmin': isAdmin,
      'password': password, 
    };
  }

}

