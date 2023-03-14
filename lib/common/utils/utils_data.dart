import 'package:delivery_codefactory/common/const/data.dart';

class UtilsData {
  static String pathToUrl(String value) {
    return 'http://$ip$value';
  }

  static List<String> listPathToUrl(List list) {
    return list.map((e) => pathToUrl(e)).toList();
  }
}
