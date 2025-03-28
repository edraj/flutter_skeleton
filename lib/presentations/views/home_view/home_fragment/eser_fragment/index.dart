import 'package:dmart_android_flutter/domain/controllers/eser/eser_arabic_controller.dart';
import 'package:dmart_android_flutter/presentations/views/home_view/home_fragment/eser_fragment/poetry_detail.dart';
import 'package:dmart_android_flutter/presentations/widgets/shimmer/list_loading_shimmer.dart';
import 'package:dmart_android_flutter/utils/helpers/translator.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EserFragment extends StatefulWidget {
  const EserFragment({super.key});

  @override
  State<EserFragment> createState() => _EserFragmentState();
}

class _EserFragmentState extends State<EserFragment> {
  final EserArabicController eserArabicController =
      Get.put(EserArabicController());

  @override
  void initState() {
    super.initState();
  }

  Future<void> _pullRefresh() async {
    eserArabicController.loadItems();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (eserArabicController.isLoading.value) {
        return const ListLoadingShimmer();
      }
      return RefreshIndicator(
        onRefresh: _pullRefresh,
        child: ListView.builder(
          physics: const AlwaysScrollableScrollPhysics(),
          itemCount: eserArabicController.records.length,
          itemBuilder: (context, index) {
            String title =
                Translator.displayname(eserArabicController.records[index]);
            return ListTile(
              title: Text(title),
              onTap: () => {
                Get.to(
                  PoetryDetail(
                    shortname: eserArabicController.records[index].shortname,
                  ),
                )
              },
            );
          },
        ),
      );
    });
  }
}
