import 'package:flutter/material.dart';

import 'package:get/get.dart';

import 'app/modules/home/bindings/home_binding.dart';
import 'app/modules/home/views/home_view.dart';
import 'app/modules/parent_tab/bindings/parent_tab_binding.dart';
import 'app/modules/parent_tab/views/parent_tab_view.dart';
import 'app/modules/splash/bindings/splash_binding.dart';
import 'app/modules/splash/controllers/splash_controller.dart';
import 'app/modules/splash/views/splash_view.dart';

import 'app/routes/app_routes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}
class MyApp extends StatelessWidget {

  final splashController = Get.put(SplashController());

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return  GetMaterialApp(
      title: 'MovieDB',
      initialRoute: Routes.SPLASH,
      getPages: [
        GetPage(name: Routes.SPLASH, page: () => SplashView(), binding: SplashBinding()),
        GetPage(name: Routes.PARENT_TAB, page: () => ParentTabView(), binding: ParentTabBinding()),
        // GetPage(name: Routes.DETAIL, page: () => DetailView(), binding: DetailBinding()),

      ],
    );
  }

}