import 'package:get/get.dart';

class FavoritesController extends GetxController {

  var index = 0.obs;
  var initialTab = 0.obs;

  setIndex(int index) {
    this.index.value = index;
  }

}
