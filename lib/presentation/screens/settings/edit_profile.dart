import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:image_picker/image_picker.dart';
import 'package:persona/data/models/user_model.dart';
import 'package:persona/data/repositories/user_respository_impl.dart';
import 'package:persona/presentation/screens/home_screen.dart';
import 'package:persona/presentation/styles/text_styles.dart';
import 'package:persona/presentation/widgets/upload_image.dart';

class EditProfile extends StatefulWidget {
  final UserModel user;
  const EditProfile({super.key, required this.user});

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _phoneNumberController = TextEditingController();
  final TextEditingController _dobController = TextEditingController();

  Gender _selectedGender = Gender.male;
  String _profilePicture = '';
  XFile? pickedImage;

  @override
  void initState() {
    _usernameController.text = widget.user.username;
    _phoneNumberController.text = widget.user.phoneNumber;
    _dobController.text = widget.user.dob;
    if (widget.user.gender == 'Gender.male') {
      _selectedGender = Gender.male;
    } else if (widget.user.gender == 'Gender.female') {
      _selectedGender = Gender.female;
    } else if (widget.user.gender == 'Gender.other') {
      _selectedGender = Gender.other;
    }
    _profilePicture = widget.user.profilePicture;
    super.initState();
  }

  Future<void> pickImage() async {
    final imageFile = await pickImageFromGalleryOrCamera(context);
    if (imageFile != null) {
      setState(() {
        pickedImage = imageFile;
      });
    }
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _phoneNumberController.dispose();
    _dobController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Profile'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(screenSize.width * 0.05),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: screenSize.height * 0.02),
                GestureDetector(
                  onTap: pickImage,
                  child: CircleAvatar(
                    radius: 60,
                    backgroundImage: pickedImage != null
                        ? FileImage(File(pickedImage!.path))
                        : FileImage(File(widget.user.profilePicture)),
                  ),
                ),
                TextFormField(
                  controller: _usernameController,
                  decoration: const InputDecoration(labelText: 'Username'),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter your username';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: _phoneNumberController,
                  decoration: const InputDecoration(labelText: 'Phone Number'),
                  keyboardType: TextInputType.phone,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter your phone number';
                    }
                    // Add additional validation if needed
                    return null;
                  },
                ),
                TextFormField(
                  controller: _dobController,
                  decoration: const InputDecoration(labelText: 'Date of Birth'),
                  readOnly: true,
                  onTap: () async {
                    final selectedDate = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(1900),
                      lastDate: DateTime.now(),
                    );
                    if (selectedDate != null) {
                      setState(() {
                        _dobController.text =
                            selectedDate.toString().split(' ')[0];
                      });
                    }
                  },
                ),
                DropdownButtonFormField<Gender>(
                  value: _selectedGender,
                  items: Gender.values.map((gender) {
                    return DropdownMenuItem<Gender>(
                      value: gender,
                      child: Text(gender.toString().split('.').last),
                    );
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      _selectedGender = value!;
                    });
                  },
                  decoration: const InputDecoration(labelText: 'Gender'),
                ),
                SizedBox(height: screenSize.height * 0.02),
                ElevatedButton(
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      if (_formKey.currentState!.validate()) {
                        final UserModel updateUser = UserModel(
                          id: widget.user.id,
                          username: _usernameController.text,
                          email: widget.user.email,
                          password: widget.user.password,
                          phoneNumber: _phoneNumberController.text,
                          gender: _selectedGender.toString().split('.').last,
                          dob: _dobController.text,
                          profilePicture: pickedImage != null
                              ? pickedImage!.path
                              : widget.user.profilePicture,
                        );

                        final userId =
                            await UserRepositoryImpl().updateUser(updateUser);
                        if (userId == true) {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    HomeScreen(email: widget.user.email)),
                          );
                        } else {
                          ScaffoldMessenger.of(context).removeCurrentSnackBar();
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Update failed!'),
                            ),
                          );
                        }
                      }
                    }
                  },
                  child: const Text('Update Profile'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
