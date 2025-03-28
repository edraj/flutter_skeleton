import 'package:dmart_android_flutter/utils/constants/themes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ThemeSwitch extends StatefulWidget {
  const ThemeSwitch({super.key});

  @override
  State<ThemeSwitch> createState() => _ThemeSwitchState();
}

class _ThemeSwitchState extends State<ThemeSwitch> {
  void switchTheme() {
    setState(() {
      Get.changeTheme(
        Get.isDarkMode
            ? ThemeManager.lightThemeData
            : ThemeManager.darkThemeData,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => switchTheme(),
      child: Icon(
        Get.isDarkMode ? Icons.light_mode : Icons.dark_mode,
        color: Colors.white,
        size: 32,
      ),
    );
  }
}
