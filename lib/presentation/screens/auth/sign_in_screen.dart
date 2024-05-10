import 'package:flutter/material.dart';
import 'package:persona/data/repositories/user_respository_impl.dart';
import 'package:persona/presentation/screens/auth/sign_up_screen.dart';
import 'package:persona/presentation/screens/home_screen.dart';
import 'package:persona/presentation/styles/text_styles.dart';

class SignInScreen extends StatefulWidget {
  @override
  _SignInScreenState createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool isVisible = false;
  bool _obscurePassword = true;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;

    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(screenSize.width * 0.05),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: screenSize.height * 0.2),
                Text(
                  'Sign In',
                  style: AppTextStyles.heading1.copyWith(
                    fontSize: screenSize.width * 0.08,
                  ),
                ),
                SizedBox(height: screenSize.height * 0.02),
                TextFormField(
                  controller: _emailController,
                  decoration: InputDecoration(
                    labelText: 'Email',
                    contentPadding: EdgeInsets.symmetric(
                      vertical: screenSize.height * 0.02,
                    ),
                  ),
                  validator: (value) => (value?.isEmpty ?? true)
                      ? 'Please enter your email'
                      : null,
                ),
                SizedBox(height: screenSize.height * 0.02),
                TextFormField(
                  controller: _passwordController,
                  decoration: InputDecoration(
                    labelText: 'Password',
                    suffixIcon: IconButton(
                      icon: Icon(
                        _obscurePassword
                            ? Icons.visibility
                            : Icons.visibility_off,
                      ),
                      onPressed: () {
                        setState(() {
                          _obscurePassword = !_obscurePassword;
                        });
                      },
                    ),
                  ),
                  obscureText: _obscurePassword,
                  validator: (value) => (value?.isEmpty ?? true)
                      ? 'Please enter your password'
                      : null,
                ),
                SizedBox(height: screenSize.height * 0.04),
                ElevatedButton(
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      final String email = _emailController.text;
                      final String password = _passwordController.text;
                      final bool isSignedIn =
                          await UserRepositoryImpl().signIn(email, password);
                      if (isSignedIn) {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => HomeScreen(email: email)),
                        );
                      } else {
                        // Show error message
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('Invalid email or password'),
                          ),
                        );
                      }
                    }
                  },
                  child: Text('Sign In'),
                ),
                SizedBox(height: screenSize.height * 0.02),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text("Didn't have an account? "),
                    TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => SignUpScreen()),
                        );
                      },
                      child: Text('Sign Up'),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
