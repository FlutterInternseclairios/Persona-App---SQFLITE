import 'package:flutter/material.dart';
import 'package:persona/data/services/authentication_status.dart';
import 'package:persona/presentation/screens/auth/sign_in_screen.dart';
import 'package:persona/presentation/screens/home_screen.dart';
import 'package:persona/presentation/screens/loading_screen.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final AuthenticationStatus authStatus = AuthenticationStatus();

    return MaterialApp(
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
      ),
      home: FutureBuilder<List<Object?>>(
        future: Future.wait([
          authStatus.isLoggedIn(),
          authStatus.getEmail(),
        ]),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const LoadingScreen(); // Show loading indicator while checking authentication status
          } else {
            if (snapshot.hasError) {
              return const LoadingScreen();
            } else {
              final bool isLoggedIn = snapshot.data?[0] as bool? ?? false;
              final String? email = snapshot.data?[1] as String?;
              if (isLoggedIn) {
                return HomeScreen(email: email ?? '');
              } else {
                return SignInScreen();
              }
            }
          }
        },
      ),
    );
  }
}
