import 'dart:io';

import 'package:flutter/material.dart';
import 'package:persona/data/models/user_model.dart';
import 'package:persona/data/repositories/user_respository_impl.dart';
import 'package:persona/presentation/screens/settings/profile_settings_screen.dart';

class HomeScreen extends StatelessWidget {
  final String email;

  const HomeScreen({super.key, required this.email});
  @override
  Widget build(BuildContext context) {
    Future<UserModel?> _currentUser = UserRepositoryImpl().getUser(email);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Persona'),
        leadingWidth: 70,
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: FutureBuilder<UserModel?>(
            future: _currentUser,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                final UserModel user = snapshot.data!;
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ProfileSettingsScreen(
                          user: user,
                        ),
                      ),
                    );
                  },
                  child: CircleAvatar(
                    radius: 2,
                    backgroundImage: FileImage(File(user.profilePicture)),
                  ),
                );
              } else if (snapshot.hasError) {
                return Center(
                  child: Text('Error fetching user data'),
                );
              }
              return Center(child: CircularProgressIndicator());
            },
          ),
        ),
      ),
      body: Center(
        child: Text('Welcome to the Persona'),
      ),
    );
  }
}
