import 'package:dmart/dmart.dart';
import 'package:dmart_android_flutter/domain/controllers/mobile_demo/data.dart';
import 'package:dmart_android_flutter/utils/helpers/snackbars.dart';
import 'package:get/get.dart';

class ServicesController extends GetxController {
  var currentSubpath = "/".obs;
  RxList<ResponseRecord> records = <ResponseRecord>[].obs;
  Rx<bool> isLoading = true.obs;

  void loadItems(String? subpath) async {
    if (subpath == null || subpath.isEmpty) {
      subpath = currentSubpath.value;
    }

    isLoading.value = true;
    update();

    QueryRequest query = QueryRequest(
        spaceName: space,
        subpath: subpath,
        queryType: QueryType.subpath,
        exactSubpath: true);

    var (response, error) = await Dmart.query(query);
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
