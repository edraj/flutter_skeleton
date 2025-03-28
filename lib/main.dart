import 'package:dmart/dmart.dart';
import 'package:dmart_android_flutter/configs/dio.dart';
import 'package:dmart_android_flutter/domain/controllers/app/app_controller.dart';
import 'package:dmart_android_flutter/presentations/views/home_view/index.dart';
import 'package:dmart_android_flutter/presentations/views/login_view.dart';
import 'package:dmart_android_flutter/utils/constants/themes.dart';
import 'package:dmart_android_flutter/utils/helpers/app_localizations.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import 'configs/dmart.dart';

class MainWidget extends StatefulWidget {
  const MainWidget({super.key});

  @override
  State<MainWidget> createState() => _MainWidgetState();
}

class _MainWidgetState extends State<MainWidget> {
  AppController appController = Get.put(AppController());

  @override
  void initState() {
    super.initState();

    SchedulerBinding.instance.addPostFrameCallback((_) {
      appController.showGreeting(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child:
          GetStorage().hasData("token") ? const HomeView() : const LoginView(),
    );
  }
}

void main() async {
  await GetStorage.init();
  await AppLocalizations.setLang();
  addInterceptors();
  String? lang = GetStorage().read("lang");
  initDmart();
  PlatformDispatcher.instance.onError = (error, stack) {
    Dmart.submit('applications', 'log', 'logs', {
      "error": {
        "class": error.toString(),
        "stack": stack.toString(),
      }
    });
    return true;
  };

  runApp(
    GetMaterialApp(
      theme: ThemeManager.lightThemeData,
      darkTheme: ThemeManager.darkThemeData,
      locale: Locale(lang ?? "en"),
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        AppLocalizationsDelegate()
      ],
      supportedLocales: const [Locale('en'), Locale('ar')],
      home: const MainWidget(),
    ),
  );
}
