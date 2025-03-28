import 'dart:io';

import 'package:dmart_android_flutter/domain/controllers/user_controller.dart';
import 'package:dmart_android_flutter/domain/models/base/displayname.dart';
import 'package:dmart_android_flutter/utils/helpers/app_localizations.dart';
import 'package:dmart_android_flutter/utils/helpers/snackbars.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class ProfileFragment extends StatefulWidget {
  const ProfileFragment({super.key});

  @override
  State<ProfileFragment> createState() => _ProfileFragmentState();
}

class _ProfileFragmentState extends State<ProfileFragment> {
  final userController = Get.put(UserController());
  bool _isEditing = false;
  XFile? _image;

  final TextEditingController _englishNameController = TextEditingController();
  final TextEditingController _arabicNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _msisdnController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  final ImagePicker _picker = ImagePicker();

  @override
  void initState() {
    super.initState();
    _englishNameController.text = userController.displayname.en ?? "";
    _arabicNameController.text = userController.displayname.ar ?? "";
    _emailController.text = userController.email ?? "";
    _msisdnController.text = userController.msisdn ?? "";
    _passwordController.text = '';
  }

  bool isAvatarChanged = false;

  Future<void> _pickImage() async {
    try {
      final XFile? pickedFile =
          await _picker.pickImage(source: ImageSource.gallery);
      if (pickedFile != null) {
        setState(() {
          _image = pickedFile;
          isAvatarChanged = true;
        });
      }
    } catch (e) {
      Snackbars.error("Error", "Could not pick the image");
    }
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required bool readOnly,
  }) {
    return TextField(
      controller: controller,
      readOnly: readOnly,
      decoration: InputDecoration(
        labelText: label,
        border: readOnly ? InputBorder.none : const OutlineInputBorder(),
      ),
    );
  }

  void handleEditButton() {
    if (_isEditing) {
      Map<String, dynamic> userAttributes = {
        "displayname": Displayname(
          en: _englishNameController.text,
          ar: _arabicNameController.text,
        ),
      };
      if (_msisdnController.text.isNotEmpty) {
        userAttributes["email"] = _emailController.text;
      }
      if (_msisdnController.text.isNotEmpty) {
        userAttributes["msisdn"] = _msisdnController.text;
      }
      if (_passwordController.text.isNotEmpty) {
        userAttributes["password"] = _passwordController.text;
      }
      userController.updateProfile(
        userController.shortname,
        userAttributes,
      );
    }
    setState(() {
      _isEditing = !_isEditing;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: ListView(
          padding: const EdgeInsets.all(16),
          children: <Widget>[
            GestureDetector(
              onTap: _isEditing ? _pickImage : null,
              child: CircleAvatar(
                radius: 50,
                backgroundImage: _image != null
                    ? FileImage(File(_image!.path))
                    : const AssetImage('assets/images/edraj_logo.png')
                        as ImageProvider,
                backgroundColor: Colors.grey[200],
              ),
            ),
            const SizedBox(height: 20),
            _buildTextField(
              controller: _englishNameController,
              label: language['english_name'],
              readOnly: !_isEditing,
            ),
            const SizedBox(height: 10),
            _buildTextField(
              controller: _arabicNameController,
              label: language['arabic_name'],
              readOnly: !_isEditing,
            ),
            const SizedBox(height: 10),
            _buildTextField(
              controller: _emailController,
              label: language['email'],
              readOnly: !_isEditing,
            ),
            const SizedBox(height: 10),
            _buildTextField(
              controller: _msisdnController,
              label: language['msisdn'],
              readOnly: !_isEditing,
            ),
            const SizedBox(height: 10),
            _buildTextField(
              controller: _passwordController,
              label: language['password'],
              readOnly: !_isEditing,
            ),
            const SizedBox(height: 24),
            ElevatedButton.icon(
              onPressed: userController.logout,
              icon: const Icon(Icons.logout), // The logout icon
              label: Text(language["logout"]), // The text 'Logout'
              style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red, //
                  textStyle: Theme.of(context).textTheme.bodyLarge),
            )
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: handleEditButton,
          child: Icon(_isEditing ? Icons.check : Icons.edit),
        ),
      ),
    );
  }
}
