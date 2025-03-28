import 'package:dmart_android_flutter/domain/controllers/eser/data.dart';
import 'package:dmart_android_flutter/domain/models/base/query/query_request.dart';
import 'package:dmart_android_flutter/domain/models/base/query/response_record.dart';
import 'package:dmart_android_flutter/domain/models/base/status.dart';
import 'package:dmart_android_flutter/domain/repositories/dmart_apis.dart';
import 'package:dmart_android_flutter/utils/enums/base/query_type.dart';
import 'package:dmart_android_flutter/utils/enums/base/sort_type.dart';
import 'package:dmart_android_flutter/utils/helpers/snackbars.dart';
import 'package:get/get.dart';

class EserArabicController extends GetxController {
  RxList<ResponseRecord> records = <ResponseRecord>[].obs;
  Rx<bool> isLoading = true.obs;

  void loadItems() async {
    isLoading.value = true;
    update();

    QueryRequest query = QueryRequest(
      spaceName: space,
      subpath: EserSubpaths.arabic.name,
      queryType: QueryType.search,
      search: '',
      exactSubpath: true,
      sortBy: "created_at",
      sortType: SortyType.ascending,
    );
    var (response, error) = await DmartAPIS.query(query);
    if (response == null) {
      Snackbars.error("Unable to fetch record", error?.message ?? "");
    } else {
      if (response.status == Status.success) {
        records.value = response.records;
      } else {
        Snackbars.error("Fetch Error!", "Unable to fetch home items.");
      }
    }

    isLoading.value = false;
    update();
  }

  @override
  void onInit() {
    super.onInit();
    loadItems();
  }
}
