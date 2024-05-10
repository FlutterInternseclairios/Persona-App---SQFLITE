import 'package:persona/data/models/user_model.dart';

abstract class UserRepository {
  Future<UserModel?> getUser(String email);
  Future<bool> updateUser(UserModel userModel);
  Future<bool> signIn(String email, String password);
  Future<void> signUp(UserModel userModel);
  Future<void> signOut();
  Future<List<Map<String, dynamic>>> getData(String tableName);
}

class Repositories {
  final UserRepository userRepository;

  Repositories({required this.userRepository});
}
