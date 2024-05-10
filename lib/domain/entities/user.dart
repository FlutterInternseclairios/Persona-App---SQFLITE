class User {
  final int? id;
  final String username;
  final String email;
  final String phoneNumber;
  final String dob;
  final Gender gender;
  final String profilePicture;
  final String password;

  User({
    this.id,
    required this.username,
    required this.email,
    required this.phoneNumber,
    required this.dob,
    required this.gender,
    required this.profilePicture,
    required this.password,
  });
}

enum Gender {
  male,
  female,
  other,
}
