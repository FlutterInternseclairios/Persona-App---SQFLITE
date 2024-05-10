import 'dart:developer';

import 'package:persona/data/constants/user_db_constants.dart';
import 'package:persona/data/data_types/data_types.dart';
import 'package:persona/data/models/user_model.dart';
import 'package:persona/data/repositories.dart';
import 'package:persona/data/services/authentication_status.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class UserRepositoryImpl implements UserRepository {
  final Future<Database> _database;
  final AuthenticationStatus _authStatus;

  UserRepositoryImpl()
      : _database = _initDatabase(),
        _authStatus = AuthenticationStatus();

  static Future<Database> _initDatabase() async {
    const databaseName = "persona.db";
    final databasePath = await getDatabasesPath();

    final path = join(databasePath, databaseName);

    try {
      return openDatabase(path, version: 1, onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE ${UsersDbConstants.usersTable} (
            ${UsersDbConstants.colId} ${DataTypes.id},
            ${UsersDbConstants.colUsername} ${DataTypes.text},
            ${UsersDbConstants.colEmail} ${DataTypes.text},
            ${UsersDbConstants.colPassword} ${DataTypes.text},
            ${UsersDbConstants.colPhoneNumber} ${DataTypes.text},
            ${UsersDbConstants.colProfilePicture} ${DataTypes.text},
            ${UsersDbConstants.colGender} ${DataTypes.text},
            ${UsersDbConstants.colDob} ${DataTypes.text}
          )
        ''');
      });
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<UserModel?> getUser(String email) async {
    try {
      final Database db = await _database;
      var res = await db.query(UsersDbConstants.usersTable,
          where: "email = ?", whereArgs: [email]);
      return res.isNotEmpty ? UserModel.fromMap(res.first) : null;
    } catch (e) {
      log(e.toString());
    }
    return null;
  }

  @override
  Future<List<Map<String, dynamic>>> getData(String tableName) async {
    final db = await _database;
    return await db.query(UsersDbConstants.usersTable,
        where: "email = ?", whereArgs: [tableName]);
  }

  @override
  Future<bool> updateUser(UserModel userModel) async {
    final Database db = await _database;
    try {
      var update = await db.update(
        UsersDbConstants.usersTable,
        userModel.toMap(),
        where: 'id = ?',
        whereArgs: [userModel.id],
      );
      if (update == 1) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      log(e.toString());
      return false;
    }
  }

  @override
  Future<bool> signIn(String email, String password) async {
    final Database db = await _database;

    var signIn = await db.rawQuery(
        "select * from users where email = '$email' AND password = '$password'");
    if (signIn.isNotEmpty) {
      await _authStatus.setLoggedIn(true);
      await _authStatus.setEmail(email);
      return true;
    } else {
      return false;
    }
  }

  @override
  Future<void> signOut() async {
    await _authStatus.clear();
    throw UnimplementedError();
  }

  @override
  Future<bool> signUp(UserModel user) async {
    final Database db = await _database;
    int signUp = await db.insert(UsersDbConstants.usersTable, user.toMap());
    if (signUp > 0) {
      await _authStatus.setLoggedIn(true);
      await _authStatus.setEmail(user.email);
      return true;
    } else {
      return false;
    }
  }
}
