import 'package:get/get.dart';

class ParentTabController extends GetxController {

  var index = 0.obs;

  void setIndex(int newIndex) {
    index.value = newIndex;
  }
}
