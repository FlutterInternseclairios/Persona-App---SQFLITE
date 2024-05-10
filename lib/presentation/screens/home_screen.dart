import 'package:flutter/material.dart';
import 'package:persona/presentation/screens/settings/profile_settings_screen.dart';

class HomeScreen extends StatelessWidget {
  final String email;

  const HomeScreen({super.key, required this.email});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: null,
        title: Text('Home'),
        actions: [
          IconButton(
              icon: Icon(Icons.settings),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ProfileSettingsScreen(
                      email: email,
                    ),
                  ),
                );
                print(email);
              }),
        ],
      ),
      body: Center(
        child: Text('Welcome to the Persona'),
      ),
    );
  }
}
