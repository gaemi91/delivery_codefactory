import 'dart:convert';

import 'package:delivery_codefactory/common/const/data.dart';

class UtilsData {
  static String pathToUrl(String value) {
    return 'http://$ip$value';
  }

  static List<String> listPathToUrl(List list) {
    return list.map((e) => pathToUrl(e)).toList();
  }

  static String valueToBase64(String value) {
    Codec<String, String> stringToBase64 = utf8.fuse(base64);

    return stringToBase64.encode(value);
  }
}
