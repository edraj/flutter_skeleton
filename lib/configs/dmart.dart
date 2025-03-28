import 'package:dmart/dmart.dart';
import 'package:dmart_android_flutter/configs/dio.dart';

initDmart() {
  Dmart.dmartServerUrl = 'https://api.dmart.cc/dmart';
  Dmart.initDmart(dio: dio);
}
