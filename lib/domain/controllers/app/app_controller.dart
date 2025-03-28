import 'package:dmart_android_flutter/domain/controllers/app/data.dart';
import 'package:dmart_android_flutter/domain/models/base/retrieve_entry_request.dart';
import 'package:dmart_android_flutter/domain/repositories/dmart_apis.dart';
import 'package:dmart_android_flutter/presentations/widgets/basic_dialog.dart';
import 'package:dmart_android_flutter/utils/constants/themes.dart';
import 'package:dmart_android_flutter/utils/enums/base/resource_type.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class AppController extends GetxController {
  Rx<ThemeData> currentThemeData = ThemeManager.lightThemeData.obs;

  Future<void> showGreeting(BuildContext context) async {
    RetrieveEntryRequest query = RetrieveEntryRequest(
      resourceType: ResourceType.content,
      spaceName: space,
      subpath: AppSubpaths.configurations.name,
      shortname: 'greeting',
      retrieveJsonPayload: true,
    );
    var (response, _) = await DmartAPIS.retrieveEntry(query, scope: "public");
    if (response == null) {
      return;
    }
    GetStorage box = GetStorage();
    if (box.read("greeting") != response.updatedAt) {
      box.write("greeting", response.updatedAt);
      Map<String, dynamic> body = response.payload?.body;
      await showBasicDialog(
        context,
        body[Get.locale?.languageCode]["title"]!,
        body[Get.locale?.languageCode]["message"]!,
      );
    }
  }

  Future<void> setTheme() async {
    currentThemeData.value = Get.isDarkMode
        ? ThemeManager.darkThemeData
        : ThemeManager.lightThemeData;
    update();
  }

  @override
  void onInit() {
    setTheme();
    super.onInit();
  }
}
