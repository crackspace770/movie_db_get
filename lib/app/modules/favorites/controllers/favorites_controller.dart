import 'package:get/get.dart';

import '../../home/model/trending_response.dart';
import '../database/db_helper.dart';

class FavoritesController extends GetxController {
  final DatabaseHelper _databaseHelper = DatabaseHelper();

  var favoriteMovies = <Trending>[].obs;
  var favoriteTvShows = <Trending>[].obs;

  @override
  void onInit() {
    super.onInit();
    fetchFavorites();
  }

  Future<void> fetchFavorites() async {
    favoriteMovies.value = await _databaseHelper.getFavoriteMovies();
    favoriteTvShows.value = await _databaseHelper.getFavoriteTvShows();
  }

  Future<void> addFavorite(Trending trending) async {
    await _databaseHelper.insertFavorite(trending);
    await fetchFavorites();
  }

  Future<void> removeFavorite(String id) async {
    await _databaseHelper.removeFavorite(id);
    await fetchFavorites();
  }

  bool isFavorite(Trending trending) {
    final isMovie = trending.mediaType == MediaType.MOVIE;
    final favorites = isMovie ? favoriteMovies : favoriteTvShows;
    return favorites.any((item) => item.id == trending.id);
  }
}


