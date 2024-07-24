import 'package:get/get.dart';

import '../../../routes/app_routes.dart';

class SplashController extends GetxController {
  @override
  void onInit() {
    super.onInit();
    navigateToAuth();
  }

  void navigateToAuth() async {
    await Future.delayed(const Duration(seconds: 4));
    Get.offAllNamed(Routes.PARENT_TAB);
  }


}
