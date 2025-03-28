import 'package:dmart_android_flutter/domain/controllers/mobile_demo/data.dart';
import 'package:dmart_android_flutter/domain/controllers/mobile_demo/services_controller.dart';
import 'package:dmart_android_flutter/domain/controllers/user_controller.dart';
import 'package:dmart_android_flutter/presentations/views/home_view/home_fragment/eser_fragment/index.dart';
import 'package:dmart_android_flutter/presentations/views/home_view/profile_fragment/index.dart';
import 'package:dmart_android_flutter/presentations/views/home_view/services_fragment/index.dart';
import 'package:dmart_android_flutter/presentations/widgets/language_change.dart';
import 'package:dmart_android_flutter/presentations/widgets/theme_switch.dart';
import 'package:dmart_android_flutter/utils/helpers/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  ServicesController servicesController = Get.put(ServicesController());
  UserController userController = Get.put(UserController());

  Future<void> setupHome() async {
    await userController.getProfile();
  }

  @override
  void initState() {
    super.initState();
    setupHome();
  }

  String appBarTitle = "";

  void setAppBarTitle(String title) {
    setState(() {
      appBarTitle = title;
    });
  }

  int _selectedIndex = 0;
  static final List<Widget> _widgetOptions = <Widget>[
    const EserFragment(),
    ServicesFragment(subpath: MobileDemoSubpaths.services.name),
    const ProfileFragment(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Obx(() {
          return servicesController.currentSubpath.value.contains('/')
              ? InkWell(
                  onTap: () {},
                  child: const Icon(
                    Icons.arrow_back,
                  ),
                )
              : Container();
        }),
        title: Text(appBarTitle),
        actions: [
          Padding(
            padding: const EdgeInsets.only(left: 16, right: 16),
            child: Row(
              children: [
                const ThemeSwitch(),
                const SizedBox(
                  width: 16,
                ),
                LanguageChange(triggerUpdate: () {
                  setState(() {});
                  return null;
                }),
              ],
            ),
          )
        ],
      ),
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: const Icon(Icons.dynamic_feed),
            label: language["eser"],
            backgroundColor: Colors.black,
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.shopping_cart),
            label: language["services"],
            backgroundColor: Colors.black,
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.person),
            label: language["profile"],
            backgroundColor: Colors.black,
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.blueAccent,
        onTap: _onItemTapped,
      ),
    );
  }
}
