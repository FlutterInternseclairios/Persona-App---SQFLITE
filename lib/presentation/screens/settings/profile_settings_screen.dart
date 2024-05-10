import 'dart:io';

import 'package:flutter/material.dart';
import 'package:persona/data/models/user_model.dart';
import 'package:persona/data/repositories/user_respository_impl.dart';
import 'package:persona/presentation/screens/auth/sign_in_screen.dart';
import 'package:persona/presentation/screens/settings/edit_profile.dart';
import 'package:persona/presentation/styles/text_styles.dart';
import 'package:persona/presentation/widgets/text_display.dart';

class ProfileSettingsScreen extends StatefulWidget {
  final String email;
  const ProfileSettingsScreen({super.key, required this.email});

  @override
  _ProfileSettingsScreenState createState() => _ProfileSettingsScreenState();
}

class _ProfileSettingsScreenState extends State<ProfileSettingsScreen> {
  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    Future<UserModel?> _currentUser =
        UserRepositoryImpl().getUser(widget.email);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile Settings'),
      ),
      body: FutureBuilder<UserModel?>(
        future: _currentUser,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final UserModel user = snapshot.data!;
            return Padding(
              padding: EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: CircleAvatar(
                      radius: 60,
                      backgroundImage: FileImage(File(user.profilePicture)),
                    ),
                  ),
                  SizedBox(height: screenSize.height * 0.02),
                  Center(
                    child: Text(
                      user.username,
                      style: AppTextStyles.subtitle1
                          .copyWith(fontWeight: FontWeight.w600),
                    ),
                  ),
                  Center(
                    child: Text(
                      user.phoneNumber,
                      style: AppTextStyles.subtitle1,
                    ),
                  ),
                  SizedBox(height: screenSize.height * 0.02),
                  UserDetailText(
                    title: 'Email',
                    trailing: user.email,
                  ),
                  UserDetailText(
                    title: 'Gender',
                    trailing: user.gender,
                  ),
                  UserDetailText(
                    title: 'Date of Birth',
                    trailing: user.dob,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => EditProfile(
                            user: user,
                          ),
                        ),
                      );
                    },
                    child: Text('Edit Details'),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => SignInScreen(),
                        ),
                      );
                    },
                    child: Text('Log Out'),
                  ),
                ],
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
    );
  }
}
