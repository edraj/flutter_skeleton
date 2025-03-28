import 'package:dmart_android_flutter/domain/controllers/mobile_demo/data.dart';
import 'package:dmart_android_flutter/domain/models/base/query/query_request.dart';
import 'package:dmart_android_flutter/domain/models/base/query/response_record.dart';
import 'package:dmart_android_flutter/domain/models/base/status.dart';
import 'package:dmart_android_flutter/domain/repositories/dmart_apis.dart';
import 'package:dmart_android_flutter/utils/enums/base/query_type.dart';
import 'package:dmart_android_flutter/utils/helpers/snackbars.dart';
import 'package:get/get.dart';

class ServicesController extends GetxController {
  Rx<String> subpath = "".obs;
  RxList<ResponseRecord> records = <ResponseRecord>[].obs;
  Rx<bool> isLoading = true.obs;

  ServicesController.init();

  ServicesController(String subpath) {
    this.subpath.value = subpath;
    loadItems();
  }

  void loadItems() async {
    isLoading.value = true;
    update();

    QueryRequest query = QueryRequest(
        spaceName: space,
        subpath: subpath.value,
        queryType: QueryType.subpath,
        exactSubpath: true);

    var (response, error) = await DmartAPIS.query(query);
    if (response == null) {
      Snackbars.error("Unable to fetch record", error?.message ?? "");
    }
    else {
      if (response.status == Status.success) {
        records.value = response.records;
      } else {
        Snackbars.error("Fetch Error!", "Unable to fetch home items.");
      }
    }

    isLoading.value = false;
    records.refresh();
    update();
  }
}
