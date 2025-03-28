import 'package:dmart_android_flutter/utils/helpers/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class LanguageChangeView extends StatefulWidget {
  const LanguageChangeView({super.key});

  @override
  State<LanguageChangeView> createState() => _LanguageChangeViewState();
}

class _LanguageChangeViewState extends State<LanguageChangeView> {
  final box = GetStorage();
  String _language = "en";

  Future<void> changeLanguage() async {
    var locale = Locale(_language);
    box.write("lang", _language);
    await Get.updateLocale(locale);
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    String? lang = box.read("lang");
    _language = lang ?? "en";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Get.back(result: true),
        ),
        title: Text(language["change_language"] ?? ""),
      ),
      body: SafeArea(
        child: Column(
          children: <Widget>[
            ListTile(
              title: Text(
                language["en"] ?? "",
              ),
              leading: Radio<String>(
                value: "en",
                groupValue: _language,
                onChanged: (String? value) {
                  setState(() {
                    _language = value ?? "";
                    changeLanguage();
                  });
                },
              ),
            ),
            ListTile(
              title: Text(
                language["ar"] ?? "",
              ),
              leading: Radio<String>(
                value: "ar",
                groupValue: _language,
                onChanged: (String? value) {
                  setState(() {
                    _language = value ?? "";
                    changeLanguage();
                  });
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
