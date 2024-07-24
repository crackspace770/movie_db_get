import 'package:get/get.dart';

import '../controllers/parent_tab_controller.dart';

class ParentTabBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ParentTabController>(
      () => ParentTabController(),
    );
  }
}
