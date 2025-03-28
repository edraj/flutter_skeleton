import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Snackbars {
  static void success(String title, String description,
      {bool suppress = false}) {
    if (suppress) {
      Get.closeAllSnackbars();
    }
    Get.snackbar(
      title,
      description,
      colorText: Colors.white,
      backgroundColor: Colors.green,
      icon: const Icon(Icons.check),
    );
  }

  static void warning(String title, String description,
      {bool suppress = false}) {
    if (suppress) {
      Get.closeAllSnackbars();
    }
    Get.snackbar(
      title,
      description,
      colorText: Colors.white,
      backgroundColor: Colors.orangeAccent,
      icon: const Icon(Icons.warning),
    );
  }

  static void error(String title, String description, {bool suppress = false}) {
    if (suppress) {
      Get.closeAllSnackbars();
    }
    Get.snackbar(
      title,
      description,
      colorText: Colors.white,
      backgroundColor: Colors.red,
      icon: const Icon(Icons.error),
    );
  }
}
