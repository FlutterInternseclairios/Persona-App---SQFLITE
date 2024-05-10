class UserModel {
  final int? id;
  final String username;
  final String email;
  final String phoneNumber;
  final String dob;
  final String gender;
  final String profilePicture;
  final String password;

  UserModel({
    this.id,
    required this.username,
    required this.email,
    required this.phoneNumber,
    required this.dob,
    required this.gender,
    required this.profilePicture,
    required this.password,
  });

  static final empty = UserModel(
      username: '',
      email: '',
      phoneNumber: '',
      dob: '',
      gender: '',
      profilePicture: '',
      password: '');

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'username': username,
      'email': email,
      'phoneNumber': phoneNumber,
      'dob': dob,
      'gender': gender,
      'profilePicture': profilePicture,
      'password': password,
    };
  }

  static UserModel fromMap(Map<String, dynamic> map) {
    return UserModel(
      id: map['id'],
      username: map['username'],
      email: map['email'],
      phoneNumber: map['phoneNumber'],
      dob: map['dob'],
      gender: map['gender'],
      profilePicture: map['profilePicture'],
      password: map['password'],
    );
  }
}

enum Gender {
  male,
  female,
  other,
}
