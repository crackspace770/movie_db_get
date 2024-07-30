import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/favorites_controller.dart';
import 'favorite_movie.dart';
import 'favorite_tv.dart';

class FavoritesView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Ensure the controller is registered
    Get.put(FavoritesController());

    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Favorites'),
          centerTitle: true,
          bottom: const TabBar(
            tabs: [
              Tab(text: 'Movies'),
              Tab(text: 'TV Shows'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            FavoriteMoviesTab(),
            FavoriteTvShowsTab(),
          ],
        ),
      ),
    );
  }
}

class FavoriteMoviesTab extends GetView<FavoritesController> {
  @override
  Widget build(BuildContext context) {
    // Ensure controller is available
    final controller = Get.find<FavoritesController>();

    return Obx(() {
      if (controller.favoriteMovies.isEmpty) {
        return const Center(child: Text('No favorite movies'));
      }

      return ListView.builder(
        itemCount: controller.favoriteMovies.length,
        itemBuilder: (context, index) {
          final movie = controller.favoriteMovies[index];
          return ListTile(
            title: Text(movie.name ?? movie.name ?? ''),
            subtitle: Text(movie.overview ?? ''),
            trailing: IconButton(
              icon: Icon(Icons.delete),
              onPressed: () => controller.removeFavorite(movie.id.toString()),
            ),
          );
        },
      );
    });
  }
}

class FavoriteTvShowsTab extends GetView<FavoritesController> {
  @override
  Widget build(BuildContext context) {
    // Ensure controller is available
    final controller = Get.find<FavoritesController>();

    return Obx(() {
      if (controller.favoriteTvShows.isEmpty) {
        return const Center(child: Text('No favorite TV shows'));
      }

      return ListView.builder(
        itemCount: controller.favoriteTvShows.length,
        itemBuilder: (context, index) {
          final tvShow = controller.favoriteTvShows[index];
          return ListTile(
            title: Text(tvShow.name ?? tvShow.name ?? ''),
            subtitle: Text(tvShow.overview ?? ''),
            trailing: IconButton(
              icon: Icon(Icons.delete),
              onPressed: () => controller.removeFavorite(tvShow.id.toString()),
            ),
          );
        },
      );
    });
  }
}
