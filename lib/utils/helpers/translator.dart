import 'package:dmart_android_flutter/domain/models/base/query/response_record.dart';
import 'package:get/get.dart';

class Translator {
  static String displayname(ResponseRecord record) {
    String fallback = record.shortname;
    switch (Get.locale?.languageCode) {
      case 'en':
        return record.attributes.displayname?.en ?? fallback;
      case 'ar':
        return record.attributes.displayname?.ar ?? fallback;
      default:
        return fallback;
    }
  }

  static String description(ResponseRecord record) {
    String fallback = record.shortname;
    switch (Get.locale?.languageCode) {
      case 'en':
        return record.attributes.description?.en ?? fallback;
      case 'ar':
        return record.attributes.description?.ar ?? fallback;
      default:
        return fallback;
    }
  }
}
