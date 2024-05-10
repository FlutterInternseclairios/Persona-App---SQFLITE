import 'dart:io';

import 'package:flutter/material.dart';
import 'package:persona/data/models/user_model.dart';
import 'package:persona/data/repositories.dart';
import 'package:persona/data/repositories/user_respository_impl.dart';
import 'package:persona/presentation/screens/auth/sign_in_screen.dart';
import 'package:persona/presentation/screens/settings/edit_profile.dart';
import 'package:persona/presentation/styles/text_styles.dart';
import 'package:persona/presentation/widgets/text_display.dart';

class ProfileSettingsScreen extends StatefulWidget {
  final UserModel user;
  const ProfileSettingsScreen({super.key, required this.user});

  @override
  _ProfileSettingsScreenState createState() => _ProfileSettingsScreenState();
}

class _ProfileSettingsScreenState extends State<ProfileSettingsScreen> {
  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;

    return Scaffold(
        appBar: AppBar(
          title: const Text('Profile Settings'),
        ),
        body: Padding(
          padding: EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: CircleAvatar(
                  radius: 60,
                  backgroundImage: FileImage(File(widget.user.profilePicture)),
                ),
              ),
              SizedBox(height: screenSize.height * 0.02),
              Center(
                child: Text(
                  widget.user.username,
                  style: AppTextStyles.subtitle1
                      .copyWith(fontWeight: FontWeight.w600),
                ),
              ),
              Center(
                child: Text(
                  widget.user.phoneNumber,
                  style: AppTextStyles.subtitle1,
                ),
              ),
              SizedBox(height: screenSize.height * 0.02),
              UserDetailText(
                title: 'Email',
                trailing: widget.user.email,
              ),
              UserDetailText(
                title: 'Gender',
                trailing: widget.user.gender,
              ),
              UserDetailText(
                title: 'Date of Birth',
                trailing: widget.user.dob,
              ),
              SizedBox(
                height: 10,
              ),
              SizedBox(
                height: 10,
              ),
              TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => EditProfile(
                        user: widget.user,
                      ),
                    ),
                  );
                },
                child: Text('Edit Details'),
              ),
              SizedBox(
                height: 10,
              ),
              TextButton(
                onPressed: () async {
                  await UserRepositoryImpl().signOut();
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
        ));
  }
}
