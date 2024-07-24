import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../favorites/views/favorites_view.dart';
import '../../home/views/home_view.dart';
import '../../search/views/search_view.dart';
import '../controllers/parent_tab_controller.dart';

class ParentTabView extends StatefulWidget {
  const ParentTabView({Key? key}) : super(key: key);

  @override
  State<ParentTabView> createState() => _ParentTabViewState();
}

class _ParentTabViewState extends State<ParentTabView> {
  final ParentTabController tabController = Get.put(ParentTabController());
  final PageController pageController = PageController(initialPage: 0);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:  PageView(
          controller: pageController,
          onPageChanged: (index) {
            tabController.setIndex(index);
          },
          children: [
            HomeView(),
            SearchView(),
            FavoritesView(),
          ],
        ),

      bottomNavigationBar: Obx(
            () => BottomNavigationBar(
          currentIndex: tabController.index.value,
          onTap: (index) {
            tabController.setIndex(index);
            pageController.jumpToPage(index);
          },
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.search),
              label: 'Search',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.favorite),
              label: 'Favorite',
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }
}


