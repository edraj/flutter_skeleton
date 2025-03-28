import 'package:dmart_android_flutter/domain/controllers/eser/eser_arabic_detail_controller.dart';
import 'package:dmart_android_flutter/domain/repositories/dmart_apis.dart';
import 'package:dmart_android_flutter/presentations/widgets/language_change.dart';
import 'package:dmart_android_flutter/presentations/widgets/shimmer/list_loading_shimmer.dart';
import 'package:dmart_android_flutter/presentations/widgets/simple_audio_player.dart';
import 'package:dmart_android_flutter/presentations/widgets/text_with_icon.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PoetryDetail extends StatefulWidget {
  final String shortname;

  const PoetryDetail({super.key, required this.shortname});

  @override
  State<PoetryDetail> createState() => _PoetryDetailState();
}

class _PoetryDetailState extends State<PoetryDetail> {
  late EserArabicDetailController eserArabicDetailController;

  @override
  void initState() {
    super.initState();
    eserArabicDetailController =
        Get.put(EserArabicDetailController(widget.shortname));
  }

  final Widget itemDivider = const Divider(
    color: Colors.black,
    indent: 16,
    endIndent: 16,
  );

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(actions: [
          LanguageChange(triggerUpdate: () {
            setState(() {});
            return null;
          })
        ]),
        body: Obx(
          () {
            if (eserArabicDetailController.isLoading.value) {
              return const ListLoadingShimmer();
            }

            if (eserArabicDetailController.poetry.value == null) {
              return const Text("XXXX");
            }

            return Container(
              constraints: const BoxConstraints(minHeight: 200),
              padding: const EdgeInsets.all(16),
              child: Card(
                elevation: 4,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      TextWithIcon(
                        text: eserArabicDetailController.poetry.value!.type,
                        icon: Icons.category,
                        textDirection: TextDirection.rtl,
                      ),
                      itemDivider,
                      TextWithIcon(
                        text: eserArabicDetailController.poetry.value!.makam,
                        icon: Icons.list,
                        textDirection: TextDirection.rtl,
                      ),
                      itemDivider,
                      TextWithIcon(
                        text: eserArabicDetailController.poetry.value!.bestekar,
                        icon: Icons.upcoming_sharp,
                        textDirection: TextDirection.rtl,
                      ),
                      itemDivider,
                      TextWithIcon(
                        text:
                            eserArabicDetailController.poetry.value!.performer,
                        icon: Icons.person,
                        textDirection: TextDirection.rtl,
                      ),
                      const Padding(
                        padding: EdgeInsets.symmetric(vertical: 32),
                        child: Divider(
                          color: Colors.black,
                          thickness: 2,
                        ),
                      ),
                      Column(
                        children: [
                          Obx(() {
                            if (eserArabicDetailController
                                    .record.value!.attachments!['media'] !=
                                null) {
                              return ListView.builder(
                                physics: const AlwaysScrollableScrollPhysics(),
                                scrollDirection: Axis.vertical,
                                shrinkWrap: true,
                                itemCount: eserArabicDetailController
                                    .record.value!.attachments!['media'].length,
                                itemBuilder: (context, index) {
                                  var attachment = eserArabicDetailController
                                      .record
                                      .value!
                                      .attachments!['media'][index];
                                  if (attachment == null) {
                                    return Container();
                                  }
                                  return SimpleAudioPlayer(
                                    title: attachment['shortname'],
                                    url: DmartAPIS.getAttachmentUrl(
                                      attachment['resource_type'],
                                      'eser',
                                      'arabic',
                                      attachment['shortname'],
                                      attachment['shortname'],
                                      'mp3',
                                    ),
                                  );
                                },
                              );
                            }
                            return Container();
                          })
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
