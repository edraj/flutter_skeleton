import 'package:dmart_android_flutter/domain/controllers/user_controller.dart';
import 'package:dmart_android_flutter/domain/models/base/displayname.dart';
import 'package:dmart_android_flutter/domain/models/create_user_model.dart';
import 'package:dmart_android_flutter/presentations/widgets/edit_field.dart';
import 'package:dmart_android_flutter/presentations/widgets/language_change.dart';
import 'package:dmart_android_flutter/presentations/widgets/theme_switch.dart';
import 'package:dmart_android_flutter/utils/constants/regex.dart';
import 'package:dmart_android_flutter/utils/helpers/advance_text_editing_controller.dart';
import 'package:dmart_android_flutter/utils/helpers/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({super.key});

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  UserController userController = Get.put(UserController());

  GlobalKey<FormState> _key = GlobalKey<FormState>();
  final _nameController = AdvanceTextEditingController();
  final _emailController = AdvanceTextEditingController();
  final _msisdnController = AdvanceTextEditingController();
  final _passwordController = AdvanceTextEditingController();

  bool isFormValid() {
    _key.currentState?.validate();
    return _nameController.isValidated &&
        _emailController.isValidated &&
        _msisdnController.isValidated &&
        _passwordController.isValidated;
  }

  List<Color> backgroundColorsLight = [
    const Color(0xB025282F),
    const Color(0xFF25282F),
  ];

  List<Color> backgroundColorsDark = [
    const Color(0xFF25282F),
    const Color(0xB025282F),
  ];

  Future<void> handleRegister() async {
    if (isFormValid()) {
      CreateUserAttributes attributes = CreateUserAttributes(
        displayname: Displayname(en: _nameController.value.text),
        email: _emailController.value.text,
        msisdn: _msisdnController.value.text,
        password: _passwordController.value.text,
        invitation: '',
      );
      userController.register(attributes);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors:
                  Get.isDarkMode ? backgroundColorsDark : backgroundColorsLight,
              stops: const [0.0, 0.95],
            ),
          ),
          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
          alignment: Alignment.center,
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const ThemeSwitch(),
                  Image.asset('assets/images/edraj_logo.png', scale: 2),
                  LanguageChange(triggerUpdate: () {
                    setState(() {});
                    _key = GlobalKey<FormState>();
                    return null;
                  }),
                ],
              ),
              // const SizedBox(height: 8),
              Text(
                language["register"],
                style: const TextStyle(
                  color: Colors.white,
                  fontFamily: 'IBMPlexSansArabic',
                  fontWeight: FontWeight.w300,
                  fontSize: 44.0,
                ),
              ),
              const SizedBox(height: 32),
              Form(
                key: _key,
                child: Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      // mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        EditField(
                          controller: _nameController,
                          palceholder: language["name"],
                          maxLength: 50,
                          // Adjust maxLength as needed
                          textInputAction: TextInputAction.next,
                          validationFunction: (value) {
                            if (value.isEmpty) {
                              return language["name_is_required"];
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 16),
                        EditField(
                          controller: _emailController,
                          palceholder: language["email"],
                          maxLength: 100,
                          // Adjust maxLength as needed
                          textInputAction: TextInputAction.next,
                          validationFunction: (value) {
                            // Implement email validation logic if needed
                            if (value.isEmpty) {
                              return language["email_is_required"];
                            } else if (!emailREGEX.hasMatch(value)) {
                              return language["wrong_format"];
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 16),
                        EditField(
                          controller: _msisdnController,
                          palceholder: language["msisdn"],
                          maxLength: 15,
                          // Adjust maxLength as needed
                          textInputAction: TextInputAction.next,
                          validationFunction: (value) {
                            if (value.isEmpty) {
                              return language["msisdn_is_required"];
                            } else if (!msisdnREGEX.hasMatch(value)) {
                              return language["wrong_format"];
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 16),
                        EditField(
                          controller: _passwordController,
                          palceholder: language["password"],
                          obscureText: true,
                          textInputAction: TextInputAction.done,
                          validationFunction: (value) {
                            if (value.isEmpty) {
                              return language["password_is_required"];
                            } else if (!passwordREGEX.hasMatch(value)) {
                              return language["wrong_format"];
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 32),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.75,
                          child: ElevatedButton(
                            onPressed: handleRegister,
                            // Assuming you have a handleRegister function
                            child: Text(
                              language["register"],
                              style: Theme.of(context).textTheme.bodyLarge,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.75,
                child: ElevatedButton(
                  onPressed: () {
                    Get.back();
                  },
                  child: Text(language["login"],
                      style: Theme.of(context).textTheme.bodyLarge),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
