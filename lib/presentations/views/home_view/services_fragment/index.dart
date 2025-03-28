import 'package:dmart_android_flutter/domain/controllers/mobile_demo/services_controller.dart';
import 'package:dmart_android_flutter/presentations/widgets/shimmer/list_loading_shimmer.dart';
import 'package:dmart_android_flutter/utils/enums/base/resource_type.dart';
import 'package:dmart_android_flutter/utils/helpers/translator.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ServicesFragment extends StatefulWidget {
  final String subpath;

  const ServicesFragment({super.key, required this.subpath});

  @override
  State<ServicesFragment> createState() => _ServicesFragmentState();
}

class _ServicesFragmentState extends State<ServicesFragment> {
  late ServicesController servicesController;

  @override
  void initState() {
    servicesController = Get.put(ServicesController(widget.subpath));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (servicesController.isLoading.value) {
        return const ListLoadingShimmer();
      }
      return GridView.builder(
        padding: const EdgeInsets.all(24),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 2,
          crossAxisSpacing: 4,
          mainAxisSpacing: 4,
        ),
        itemCount: servicesController.records.length,
        itemBuilder: (context, index) {
          String title =
              Translator.displayname(servicesController.records[index]);
          return Card(
            child: InkWell(
              onTap: () {
                if (servicesController.records[index].resourceType ==
                    ResourceType.folder) {
                  servicesController.subpath.value =
                      "${widget.subpath}/${servicesController.records[index].shortname}";
                  servicesController.loadItems();
                }
              },
              child: Center(
                child: Text(title),
              ),
            ),
          );
        },
      );
    });
  }
}
